{ config, pkgs, ... }:
{
	imports = [
		./home-headless.nix
	];

	home.file = {
		".xinitrc".text = ''exec i3'';

		".config/alacritty/alacritty.yml".source =  config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/desktop/alacritty/.config/alacritty/alacritty.yml";
		".config/i3".source =  config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/desktop/i3/.config/i3";
		".config/i3status".source =  config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/desktop/i3/.config/i3status";
		".config/sxiv".source =  config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/desktop/sxiv/.config/sxiv";
		".Xresources".source =  config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/desktop/xresources/.Xresources";
		".config/zathura/zathurarc".source =  config.lib.file.mkOutOfStoreSymlink "/home/filipe/dotfiles/desktop/zathura/.config/zathura/zathurarc";
	};
}
