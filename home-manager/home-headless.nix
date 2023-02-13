{ config, pkgs, ... }:
{
	home.username = "filipe";
	home.homeDirectory = "/home/filipe";

	home.file = {
		".config/tealdeer/config.toml".text = ''
			[updates]
			auto_update = true
		'';

		".gitconfig".source =  config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/headless/git/.gitconfig";
		".config/nvim".source =  config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/headless/nvim/.config/nvim";
		".inputrc".source =  config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/headless/readline/.inputrc";
		".screenrc".source =  config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/headless/screen/.screenrc";
		".tmux.conf".source =  config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/headless/tmux/.tmux.conf";
		".vimrc".source =  config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/headless/vim/.vimrc";
		".zshrc".text = builtins.readFile "/home/filipe/dotfiles/headless/zsh/.zshrc" + ''
			source "${pkgs.zsh-forgit}/share/zsh/zsh-forgit/forgit.plugin.zsh";
		'';
	};

	home.stateVersion = "22.11";

	programs.home-manager.enable = true;
}
