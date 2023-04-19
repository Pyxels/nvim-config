{
  description = "Pyxels Neovim Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      # For `nix develop` / direnv
      devShell.${system} = pkgs.mkShell {
        packages = with pkgs; [
          stylua
        ];
      };
    };
}

