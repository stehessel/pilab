{
  description = "stehessel's pilab";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = inputs.nixpkgs.lib.systems.flakeExposed;

      imports = [
        inputs.pre-commit-hooks.flakeModule
      ];

      perSystem = {
        config,
        pkgs,
        system,
        ...
      }: {
        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };

        devShells.default = pkgs.mkShell {
          inputsFrom = [
            config.pre-commit.devShell
          ];
          packages = builtins.attrValues config.packages;
        };

        packages = {
          inherit
            (pkgs)
            ansible
            sshpass
            ;
        };

        pre-commit.settings.imports = [./nix/pre-commit.nix];
      };
    };
}
