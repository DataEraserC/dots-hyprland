{
  stdenvNoCC,
  fetchgit,
  lib,
  slurp,
  swww,
  ags,
  fcitx5,
  gnome,
  polkit_gnome,
  hypridle,
  dbus,
  wl-clipboard,
  hyprland,
  microsoft-edge,
  qt5ct,
  ...
}:
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

    # Handle .config/hypr

    # Some config should be separated from this ---> nope should place the together to make packaging more easily
    # Fix file path
    # hyprland.conf
    # sed -i "5,10s@~@$out@g" $out/.config/hypr/hyprland.conf
    # custom_dir does not need to modify but should fix in $out/hypr/hyprland.conf
    # Or Let user make a nix derivation
    # sed -i "13,17s@~@$out@g" $out/.config/hypr/hyprland.conf

    # Handle .config/hypr/hyprland.conf
    substituteInPlace $out/.config/hypr/hyprland/general.conf  \
      --replace "~/.config" "$out/.config"
    substituteInPlace $out/.config/hypr/hyprland.conf \
      --replace "~/.config" "$out/.config"
    substituteInPlace $out/.config/hypr/hyprlock.conf \
      --replace "~/.config" "$out/.config"

    # should set in deps not hardcode into config -> no I will make them in runtimedeps

    # Handle .config/hypr/hyprland/execs.conf
    substituteInPlace $out/.config/hypr/hyprland/execs.conf \
      --replace "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1" "${polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"

    # Handle .config/hypr/hyprland/keybinds.conf
    substituteInPlace $out/.config/hypr/hyprland/keybinds.conf \
      --replace "/usr/bin/microsoft-edge-stable" "microsoft-edge-stable" \
      --replace "~/.config" "$out/.config"

    # Handle .config/qt5ct
    # Handle .config/qt5ct/qt5ct.conf
    substituteInPlace $out/.config/qt5ct/qt5ct.conf \
      --replace "/usr/share/qt5ct/colors/darker.conf" "${qt5ct}/share/qt5ct/colors/darker.conf"



    # Handle .config/ags

    # Handle .config/ags/user_options.js
    substituteInPlace $out/.config/ags/user_options.js \
      --replace "~/.config" "$out/.config"

    # Handle .config/ags/config_overviewOnly.js
    substituteInPlace $out/.config/ags/config_overviewOnly.js \
      --replace "~/.config" "$out/.config"

    # Handle .config/ags/scripts/templates/hypr/hyprlock.conf
    substituteInPlace $out/.config/ags/scripts/templates/hypr/hyprlock.conf \
      --replace "~/.config" "$out/.config"

    # Handle .config/ags/scripts/color_generation
    substituteInPlace $out/.config/ags/scripts/color_generation/applycolor.sh \
      --replace "\"HOME\"/.config" "$out/.config"
    substituteInPlace $out/.config/ags/scripts/color_generation/colorgen.sh \
      --replace "\"HOME\"/.config" "$out/.config"
    substituteInPlace $out/.config/ags/scripts/color_generation/switchcolor.sh \
      --replace "\"HOME\"/.config" "$out/.config"
    substituteInPlace $out/.config/ags/scripts/color_generation/switchwall.sh \
      --replace "\"HOME\"/.config" "$out/.config"


    # Handle .config/ags/modules

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
