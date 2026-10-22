{
  description = "dotfiles";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager }:
    let
    system = "x86_64-linux"; # change to aarch64-linux if on ARM Windows
    user = "whisper";
  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };
  in
  {
    homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { inherit user; };
      modules = [ 
      {
        nixpkgs.overlays = [
          (final: prev: {
           claude-code = (import nixpkgs-unstable {
               system = prev.stdenv.hostPlatform.system;
               config.allowUnfree = true;   # claude-code is unfree
               }).claude-code;
           })
        ];
      }
        ./home.nix
      ];
    };
  };
}
