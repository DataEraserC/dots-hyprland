# First import me
# Enable using:
# features.end-4_dots-hyprland.enable = true;
{ config
, lib
, pkgs
, ...
}@inputs:
let
  cfg = config.modules.desktop.end_4-dots_hyprland-nixos_module;
in
{
  options = {
    modules.desktop.end_4-dots_hyprland-nixos_module = with lib; {
      enable = mkEnableOption "end-4 's hyprland (nixos-module part)";
    };
  };

  config = lib.mkIf cfg.enable {
    fonts = lib.mkDefault {
      # Install fonts at system-level, not user-level
      fontconfig.enable = false;
      # use fonts specified by user rather than default ones
      enableDefaultPackages = false;
      fontDir.enable = true;
      packages = [ pkgs.rubik ];
    };
  };
}
