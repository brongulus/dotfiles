{
  description = "Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    home-manager.url = "github:nix-community/home-manager";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, home-manager, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations.prashant = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # Specify the path to your home configuration here
        # configuration = import ./home.nix;

        modules = [
          ./home.nix
          {
            home = {
              username = "prashant";
              homeDirectory = "/home/prashant";
              # Update the state version as needed.
              # See the changelog here:
              # https://nix-community.github.io/home-manager/release-notes.html#sec-release-21.05
              stateVersion = "22.11";
            };
          }
        ];
      };
    };
}
