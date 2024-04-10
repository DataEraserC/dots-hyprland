{ inputs
, pkgs
, lib
, ...
}:
let mkPath = (f: ./. + "${f}");
in
{
  home.file = (lib.mkMerge map
    (f: {
      ".config/${f}" = {
        source = mkPath "${inputs.end-4_dots-hyprland}/.config/${f}";
        recursive = true;
        executable = true;
      };
    }) [
    "ags"
    "anyrun"
    "fish"
    "footconfig"
    "foot"
    "fuzzel"
    "hypr"
    "mpv"
    "qt5ct"
    "wlogout"
    "zshrc.d"
  ]) ++ {
    ".config/thorium-flags.conf".source = ./. + "${inputs.end-4_dots-hyprland}/.config/thorium-flags.conf";
    #"starship.toml".source = ./. + "${inputs.end-4_dots-hyprland}/.config/starship.toml";
  };
}
