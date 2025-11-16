# Some CI checks to ensure this template always works.
# Feel free to adapt or remove when this repo is yours.
{ inputs, ... }:
{
  perSystem =
    {
      pkgs,
      self',
      lib,
      ...
    }:
    let
      checkCond = name: cond: pkgs.runCommandLocal name { } (if cond then "touch $out" else "");
      apple = inputs.self.darwinConfigurations.apple.config;
      appleBuilds = !pkgs.stdenvNoCC.isDarwin || builtins.pathExists (apple.system.build.toplevel);
    in
    {
      checks."apple builds" = checkCond "apple-builds" appleBuilds;
    };
}
