# First import me
# Enable using:
# features.end-4_dots-hyprland.enable = true;
{ config
, lib
, pkgs
, ags
, anyrun
, ...
}@inputs:
let

  cfg = config.modules.desktop.end_4-dots_hyprland-hm_module;
in
{
  options.modules.desktop.end_4-dots_hyprland-hm_module = with lib; {
    enable = mkEnableOption "end-4 's hyprland(hm-module part)";
  };

  config = lib.mkIf cfg.enable {
    imports = [
      ags.homeManagerModules.default
      anyrun.homeManagerModules.default
      ./ags.nix
      ./anyrun.nix
      ./browser.nix
      ./dconf.nix
      ./dotfiles.nix
      ./mimelist.nix
      ./packages.nix
      ./starship.nix
      ./sway.nix
      ./theme.nix
    ];
    home = {
      sessionVariables = {
        NIXPKGS_ALLOW_UNFREE = lib.mkDefault "1";
        NIXPKGS_ALLOW_INSECURE = lib.mkDefault "1";
        NIXPKGS_ALLOW_BROKEN = lib.mkDefault "1";
      };
      sessionPath = [
        "$HOME/.local/bin"
      ];
    };

    xdg.userDirs = {
      createDirectories = true;
    };
    gtk = {
      enable = lib.mkDefault true;
      font = lib.mkDefault {
        name = "Rubik";
        package = pkgs.google-fonts.override { fonts = [ "Rubik" ]; };
        size = 11;
      };
      gtk3 = {
        bookmarks = lib.mkDefault [
          "file://${config.home.homeDirectory}/Downloads"
          "file://${config.home.homeDirectory}/Documents"
          "file://${config.home.homeDirectory}/Pictures"
          "file://${config.home.homeDirectory}/Music"
          "file://${config.home.homeDirectory}/Videos"
          "file://${config.home.homeDirectory}/.config"
          "file://${config.home.homeDirectory}/.config/ags"
          "file://${config.home.homeDirectory}/.config/hypr"
          "file://${config.home.homeDirectory}/GitHub"
          "file:///mnt/Windows"
        ];
      };

    };

    programs = {
      home-manager.enable = true;
    };

    home.stateVersion = "23.11"; # this must be the version at which you have started using the program
  };
}
