# Some CI checks to ensure this template always works.
# Feel free to adapt or remove when this repo is yours.
{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      ...
    }:
    let
      checkCond = name: cond: pkgs.runCommandLocal name { } (if cond then "touch $out" else "");
      agro = inputs.self.darwinConfigurations.agro.config;
      agroBuilds = !pkgs.stdenvNoCC.isDarwin || builtins.pathExists (agro.system.build.toplevel);
      homeBuilds = !pkgs.stdenvNoCC.isDarwin || builtins.pathExists (inputs.self.homeConfigurations.benny.activation-script + "/activate");
    in
    {
      checks.host-builds = checkCond "agroBuilds" agroBuilds;
      checks.home-builds = checkCond "homeBuilds" homeBuilds;
    };
}
