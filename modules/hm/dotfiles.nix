{ pkgs
, lib
,end_4-dots_hyprland
, ...
}@inputs:
let
  mkRootPath = (f: /. + "{f}");
  mkHomeConfigPath = (path: f: {
    ".config/${f}" = {
      source = mkRootPath "${path}/.config/${f}";
      recursive = true;
      executable = true;
    };
  });
in
{
  home.file = (lib.mkMerge

    ((map (mkHomeConfigPath "${end_4-dots_hyprland}")
      [
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
      ])
    ++
    [{
      ".config/thorium-flags.conf".source = ./. + "/${end_4-dots_hyprland}/.config/thorium-flags.conf";
      #"starship.toml".source = ./. + "${end_4-dots_hyprland}/.config/starship.toml";
    }])
  );
}
