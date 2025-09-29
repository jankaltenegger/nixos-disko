{
  description = "My personal disko setups for different machines";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
  };

  outputs = { self, nixpkgs, disko, ... }@inputs: {
    templates = {
      host = {
        path = ./machine/ymir;
      };
    };
  };
}
