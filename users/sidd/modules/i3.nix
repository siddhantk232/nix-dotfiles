{ pkgs, ... }:
{
  xdg.configFile."i3/config".text = builtins.readFile ../config/i3/config;
  xdg.configFile."i3/i3status-rs.toml".text = builtins.readFile ../config/i3/i3status-rs.toml;
  home.packages = with pkgs; [
    (st.overrideAttrs (oldAttrs: rec {
      src = fetchFromGitHub {
        owner = "LukeSmithxyz";
        repo = "st";
        rev = "36d225d71d448bfe307075580f0d8ef81eeb5a87";
        sha256 = "sha256-u8E8/aqbL3T4Sz0olazg7VYxq30haRdSB1SRy7MiZiA=";
      };
      configFile = writeText "config.def.h" (builtins.readFile ../config/st/config.h);
      postPatch = "${oldAttrs.postPatch}\n cp ${configFile} config.h";
      buildInputs = oldAttrs.buildInputs ++ [ harfbuzz ];
    }))
    (pkgs.rofi.override { plugins = [ pkgs.rofi-emoji ]; })
    pkgs.betterlockscreen
  ];
}
