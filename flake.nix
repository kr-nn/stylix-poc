{
  description = "Stylix issue POC";

  inputs = {

    # NIXPKGS
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # Stylix
    stylix.url = "github:danth/stylix/release-24.05";

    # HOME-MANAGER
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
    };

  };

  outputs = { nixpkgs, stylix, home-manager, ... }:

  # ARGS ========================================================================
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {

  # HOMES ========================================================================

    homeConfigurations."kyle" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./hm/_home.nix
        stylix.homeManagerModules.stylix
      ];
    };
  };
}
