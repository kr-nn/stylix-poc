{ ... }:

{
  imports = [
   ../theme/_theme.nix
  ];

  home.username = "kyle";
  home.homeDirectory = "/home/kyle";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}

