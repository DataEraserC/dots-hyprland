# First import me
# Enable using:
# features.end-4_dots-hyprland.enable = true;
{ config, lib, end-4_dots-hyprland, hyprland, hyprland-plugins, pkgs, ... }:
let
  cfg = config.features.end-4_dots-hyprland;
  mkPath = (f: ./. + "${f}");
  mkXdgConfigFileAttr = (f: {
    f = {
      source = mkPath "${end-4_dots-hyprland}/.config/${f}";
      recursive = true;
    };
  });
  mkXdgConfigFile = (f: {
    source = mkPath "${end-4_dots-hyprland}/.config/${f}";
    recursive = true;
  });
in {
  options.features.sunshine = with lib; {
    enable = mkEnableOption "end-4 's hyprland";
  };

  config = lib.mkIf cfg.enable {
    # NOTE:
    # We have to enable hyprland/i3's systemd user service in home-manager,
    # so that gammastep/wallpaper-switcher's user service can be start correctly!
    # they are all depending on hyprland/i3's user graphical-session
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        env = [
          "NIXOS_OZONE_WL,1" # for any ozone-based browser & electron apps to run on wayland
          "MOZ_ENABLE_WAYLAND,1" # for firefox to run on wayland
          "MOZ_WEBRENDER,1"
          # misc
          "_JAVA_AWT_WM_NONREPARENTING,1"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
          "QT_QPA_PLATFORM,wayland"
          "SDL_VIDEODRIVER,wayland"
          "GDK_BACKEND,wayland"
        ];
      };
      package = hyprland.packages.${pkgs.system}.hyprland;
      extraConfig = builtins.readFile mkPath
        "${end-4_dots-hyprland}/.config/hypr/hyprland.conf";
      plugins = [
        hyprland-plugins.packages.${pkgs.system}.hyprbars
        # ...
      ];
      # gammastep/wallpaper-switcher need this to be enabled.
      systemd.enable = true;
    };
    xdg.configFile = (mkXdgConfigFileAttr "ags")
      // (mkXdgConfigFileAttr "anyrun") // (mkXdgConfigFileAttr "fish")
      // (mkXdgConfigFileAttr "footconfig") // (mkXdgConfigFileAttr "foot")
      // (mkXdgConfigFileAttr "fuzzel") // (mkXdgConfigFileAttr "hypr")
      // (mkXdgConfigFileAttr "mpv") // (mkXdgConfigFileAttr "qt5ct")
      // (mkXdgConfigFileAttr "wlogout") // (mkXdgConfigFileAttr "zshrc.d");
  };
}
