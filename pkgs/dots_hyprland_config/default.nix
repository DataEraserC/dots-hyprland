{ stdenvNoCC, fetchgit, lib, slurp, swww, ags, fcitx5, gnome, polkit_gnome, hypridle, dbus, wl-clipboard, hyprland,microsoft-edge, ... }:
stdenvNoCC.mkDerivation rec {
  pname = "dots_hyprland_config";
  version = "0.0-0";
  src = ../..;

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/
    cp -ar ${src}/. $out
    chmod -R +w .

    # Some config should be separated from this ---> nope should place the together to make packaging more easily
    # Fix file path
    # hyprland.conf
    substituteInPlace $out/.config/hypr/hyprland.conf --replace "~" "$out"
    # sed -i "5,10s@~@$out@g" $out/.config/hypr/hyprland.conf
    # custom_dir does not need to modify but should fix in $out/hypr/hyprland.conf
    # Or Let user make a nix derivation 
    # sed -i "13,17s@~@$out@g" $out/.config/hypr/hyprland.conf
    
    # should set in deps not hardcode into config

    # execs replace here
    # sed -i "s@slurp@${slurp}/bin/slurp@g" $out/.config/hypr/hyprland/colors.conf
    # sed -i "s@swww-daemon@${swww}/bin/swww-daemon@g" $out/.config/hypr/hyprland/execs.conf
    # sed -i "s@ags@${ags}/bin/ags@g" $out/.config/hypr/hyprland/execs.conf
    # sed -i "s@fcitx5@${fcitx5}/bin/fcitx5@g" $out/.config/hypr/hyprland/execs.conf
    # sed -i "s@gnome-keyring-daemon@${gnome.gnome-keyring}/bin/gnome-keyring-daemon@g" $out/.config/hypr/hyprland/execs.conf
    substituteInPlace $out/.config/hypr/hyprland/execs.conf --replace "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1" "${polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"
    # sed -i "s@/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1@${polkit_gnome}/libexec/polkit-gnome-authentication-agent-1@g" $out/.config/hypr/hyprland/execs.conf
    # sed -i "s@hypridle@${hypridle}/bin/hypridle@g" $out/.config/hypr/hyprland/execs.conf
    # sed -i "s@dbus-update-activation-environment@${dbus}/bin/dbus-update-activation-environment@g" $out/.config/hypr/hyprland/execs.conf
    # sed -i "s@wl-paste@${wl-clipboard}/bin/wl-paste@g" $out/.config/hypr/hyprland/execs.conf
    # sed -i "s@hyprland@${hyprland}/bin/hyprctl@g" $out/.config/hypr/hyprland/execs.conf

    # keybinds replace here
    substituteInPlace $out/.config/hypr/hyprland/keybinds.conf --replace "/usr/bin/microsoft-edge-stable" "microsoft-edge-stable" --replace "~" "$out"
    # sed -i "s@/usr/bin/microsoft-edge-stable@${microsoft-edge}/bin/microsoft-edge-stable@g" $out/.config/hypr/hyprland/keybinds.conf
    # sed -i "s@~/.local/bin/fuzzel-emoji@ placeholder @g" $out/.config/hypr/hyprland/keybinds.conf
    # sed -i "s@~/.config/ags@ placeholder @g" $out/.config/hypr/hyprland/keybinds.conf
    
    runHook postInstall
  '';

  meta = with lib; {
    description = "end-4's dots hyprland config";
    homepage = "https://github.com/end-4/dots-hyprland";
    platforms = platforms.linux;
    license = licenses.gpl3;
    # maintainers = with maintainers; [ Program-Learning ];
  };
}
