{ config, pkgs, lib, ... }:
let

  # Return AttrSet ======================================================
  main = {
    specialisation.alt.configuration = lib.mkMerge [ alt colorMap { stylix.enable = true; } ];
    specialisation.default.configuration = lib.mkMerge [ default colorMap { stylix.enable = true; } ];
    stylix.image = lib.mkDefault fallback.stylix.image;
    home.file = {
      "${config.home.homeDirectory}/Stylix.md".text = formatConfig colorsmap;
    };
  };

  # Papers ==============================================================

  ## Fallback
  fallback = { stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/pk/wallhaven-pkrqze.png";
    sha256 = "07zl1dlxqh9dav9pibnhr2x1llywwnyphmzcdqaby7dz5js184ly"; }; };

  ## Default
  default = { stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/lq/wallhaven-lqmzkq.jpg";
    sha256 = "1fsja8fk86b8n971gmfw963f338s6z7yf5706a3sfn94ly22hw0b"; }; };

  ## Alt
  alt = { stylix.image = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/gj/wallhaven-gj2rod.jpg";
    sha256 = "017n6f9f2q0zyy5dca197qg7h1wkkq9qm08fyx09p0hk1ajmz0r3"; }; };

  # META ================================================================
  formatValue = value:
    if builtins.isBool value
    then if value then "true" else "false"
    else builtins.toString value;

  formatSection = path: data:
    let
      header = lib.concatStrings (map (p: "[${p}]") path);
      formatChild = name: formatLines (path ++ [ name ]);
      children = lib.mapAttrsToList formatChild data;
      partitioned = lib.partition builtins.isString children;
      directChildren = partitioned.right;
      indirectChildren = partitioned.wrong;
    in
      lib.optional (directChildren != []) header ++
      directChildren ++
      lib.flatten indirectChildren;

  formatLines = path: data:
    if builtins.isAttrs data
    then
      formatSection path data
    else "${lib.last path}=${formatValue data}";

  formatConfig = data:
    lib.concatStringsSep "\n" (formatLines [] data);

  colorsmap = with config.lib.stylix.colors; {
    normal = {
    base00 = "${base00}";
    base01 = "${base01}";
    base02 = "${base02}";
    base03 = "${base03}";
    base04 = "${base04}";
    base05 = "${base05}";
    base06 = "${base06}";
    base07 = "${base07}";
    base08 = "${base08}";
    base09 = "${base09}";
    base0A = "${base0A}";
    base0B = "${base0B}";
    base0C = "${base0C}";
    base0D = "${base0D}";
    base0E = "${base0E}";
    base0F = "${base0F}";
    };

    RGB = {
    base00 = "${base00-rgb-r} | ${base00-rgb-g} | ${base00-rgb-b}";
    base01 = "${base01-rgb-r} | ${base01-rgb-g} | ${base01-rgb-b}";
    base02 = "${base02-rgb-r} | ${base02-rgb-g} | ${base02-rgb-b}";
    base03 = "${base03-rgb-r} | ${base03-rgb-g} | ${base03-rgb-b}";
    base04 = "${base04-rgb-r} | ${base04-rgb-g} | ${base04-rgb-b}";
    base05 = "${base05-rgb-r} | ${base05-rgb-g} | ${base05-rgb-b}";
    base06 = "${base06-rgb-r} | ${base06-rgb-g} | ${base06-rgb-b}";
    base07 = "${base07-rgb-r} | ${base07-rgb-g} | ${base07-rgb-b}";
    base08 = "${base08-rgb-r} | ${base08-rgb-g} | ${base08-rgb-b}";
    base09 = "${base09-rgb-r} | ${base09-rgb-g} | ${base09-rgb-b}";
    base0A = "${base0A-rgb-r} | ${base0A-rgb-g} | ${base0A-rgb-b}";
    base0B = "${base0B-rgb-r} | ${base0B-rgb-g} | ${base0B-rgb-b}";
    base0C = "${base0C-rgb-r} | ${base0C-rgb-g} | ${base0C-rgb-b}";
    base0D = "${base0D-rgb-r} | ${base0D-rgb-g} | ${base0D-rgb-b}";
    base0E = "${base0E-rgb-r} | ${base0E-rgb-g} | ${base0E-rgb-b}";
    base0F = "${base0F-rgb-r} | ${base0F-rgb-g} | ${base0F-rgb-b}";
    };

    HEX = {
    base00 = "${base00-hex}";
    base01 = "${base01-hex}";
    base02 = "${base02-hex}";
    base03 = "${base03-hex}";
    base04 = "${base04-hex}";
    base05 = "${base05-hex}";
    base06 = "${base06-hex}";
    base07 = "${base07-hex}";
    base08 = "${base08-hex}";
    base09 = "${base09-hex}";
    base0A = "${base0A-hex}";
    base0B = "${base0B-hex}";
    base0C = "${base0C-hex}";
    base0D = "${base0D-hex}";
    base0E = "${base0E-hex}";
    base0F = "${base0F-hex}";
    };
  };

  colorMap = {
    home.file = {
      "${config.home.homeDirectory}/Stylix.md".text = formatConfig colorsmap;
    };
  };

in
main
