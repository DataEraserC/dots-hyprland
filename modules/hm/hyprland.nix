{ pkgs
, hyprland
, hyprland-plugins
, ...
}@inputs:
let
  hyprland = hyprland.packages.${pkgs.system}.hyprland;
  plugins = hyprland-plugins.packages.${pkgs.system};

  launcher = pkgs.writeShellScriptBin "hypr" ''
    #!/${pkgs.bash}/bin/bash

    export WLR_NO_HARDWARE_CURSORS=1
    export _JAVA_AWT_WM_NONREPARENTING=1

    exec ${hyprland}/bin/Hyprland
  '';
in
{
  home.packages = with pkgs; [
    launcher
    adoptopenjdk-jre-bin
  ];

  xdg.desktopEntries."org.gnome.Settings" = {
    name = "Settings";
    comment = "Gnome Control Center";
    icon = "org.gnome.Settings";
    exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome.gnome-control-center}/bin/gnome-control-center";
    categories = [ "X-Preferences" ];
    terminal = false;
  };

  programs = {
    swaylock = {
      enable = true;
      package = pkgs.swaylock-effects;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;
  };
}
