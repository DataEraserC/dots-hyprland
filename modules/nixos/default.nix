# First import me
# Enable using:
# features.end-4_dots-hyprland.enable = true;
{ config
, lib
, end-4_dots-hyprland
, hyprland
, hyprland-plugins
, pkgs
, ...
}:
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
in
{
  options = {
    features.end-4_dots-hyprland = with lib; {
      enable = mkEnableOption "end-4 's hyprland (nixos-module part)";
    };
  };

  config = lib.mkIf cfg.enable {
    # Install fonts at system-level, not user-level
    fonts.fontconfig.enable = false;

    fonts = {
      # use fonts specified by user rather than default ones
      enableDefaultPackages = false;
      fontDir.enable = true;
      packages = [ pkgs.rubik ];
    };
  };
}
