{ config, ... }:
with builtins;
{
	home.username = "filipe";
	home.homeDirectory = "/home/filipe";

	home.stateVersion = "22.11";

	programs.home-manager.enable = true;

	home.file = {
		".gitconfig".source = "/home/filipe/dotfiles/headless/git/.gitconfig";
		".config/nvim".source = "/home/filipe/dotfiles/headless/nvim/.config/nvim";
		".inputrc".source = "/home/filipe/dotfiles/headless/readline/.inputrc";
		".screenrc".source = "/home/filipe/dotfiles/headless/screen/.screenrc";
		".tmux.conf".source = "/home/filipe/dotfiles/headless/tmux/.tmux.conf";
		".vimrc".source = "/home/filipe/dotfiles/headless/vim/.vimrc";
		".zshrc".source = "/home/filipe/dotfiles/headless/zsh/.zshrc";

		".config/alacritty/alacritty.yml".source = "/home/filipe/dotfiles/desktop/alacritty/.config/alacritty/alacritty.yml";
		".config/i3".source = "/home/filipe/dotfiles/desktop/i3/.config/i3";
		".config/i3status".source = "/home/filipe/dotfiles/desktop/i3/.config/i3status";
		".config/sxiv".source = "/home/filipe/dotfiles/desktop/sxiv/.config/sxiv";
		".Xresources".source = "/home/filipe/dotfiles/desktop/xresources/.Xresources";
		".config/zathura/zathurarc".source = "/home/filipe/dotfiles/desktop/zathura/.config/zathura/zathurarc";
	};
}
