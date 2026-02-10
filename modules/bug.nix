{ den, inputs, ... }:
{
  den.hosts.x86_64-linux.igloo.users.tux = { };

  # Use aspects to create a **minimal** bug reproduction
  den.aspects.tux.includes = [
    (den._.unfree ["steam" "steam-unwrapped"])
    {
      homeManager = { pkgs, ... }: {
        home.packages = [
          pkgs.steam
        ];
      };
    }
  ];

  # rename "it works", evidently it has bugs
  flake.tests."test it works" =
    let
      expr.packages-load = inputs.self.nixosConfigurations.igloo.config.home-manager.users.tux.home ? packages;

      expected.packages-load = true;
    in
    {
      inherit expr expected;
    };
}