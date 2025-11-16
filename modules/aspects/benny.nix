{ den, eg, ... }:
{
  den.aspects.benny = {

    # Alice can include other aspects.
    # For small, private one-shot aspects, use let-bindings like here.
    # for more complex or re-usable ones, define on their own modules,
    # as part of any aspect-subtree.
    includes =
      let
        # deadnix: skip # not required, showcasing angle-brackets syntax.
        inherit (den.lib) __findFile;

        customEmacs.homeManager =
          { pkgs, ... }:
          {
            programs.emacs.enable = true;
            programs.emacs.package = pkgs.emacs30;
          };
      in
      [
        # from local bindings.
        customEmacs
        # from the aspect tree, cooper example is defined below
        den.aspects.setHost
        # from the `eg` namespace.
        eg.autologin
        # den included batteries that provide common configs.
        <den/primary-user> # admin
        (<den/user-shell> "fish") # default user shell
      ];

    # Alice configures NixOS hosts it lives on.
    nixos =
      { pkgs, ... }:
      {
        users.users.benny.packages = [ pkgs.neovim ];
      };

    # Alice home-manager.
    homeManager =
      { pkgs, config, ... }:
      {
        home.packages = [ pkgs.htop ];
	programs.nh.enable = true;
	xdg.enable = true;

	home.file."${config.home.homeDirectory}/.hammerspoon/init.lua".source = ../../resources/home/hammerspoon/init.lua;
	home.file."${config.home.homeDirectory}/.hammerspoon/Spoons/PaperWM.spoon".source = ../../resources/hammerspoon/Spoons/PaperWM.spoon;
	home.file."${config.home.homeDirectory}/.hammerspoon/Spoons/ActiveSpace.spoon".source = ../../resources/home/hammerspoon/Spoons/ActiveSpace.spoon;

	home.activation.reloadHammerspoon = config.lib.dag.entryAfter [ "writeBoundary" ] ''
          $DRY_RUN_CMD /Applications/Hammerspoon.app/Contents/Frameworks/hs/hs -c "hs.reload()"
          $DRY_RUN_CMD sleep 1
          $DRY_RUN_CMD /Applications/Hammerspoon.app/Contents/Frameworks/hs/hs -c "hs.console.clearConsole()"
        '';
        };

    # <user>.provides.<host>, via eg/routes.nix
    provides.igloo =
      { host, ... }:
      {
        nixos.programs.nh.enable = host.name == "igloo";
      };
  };

  # This is a context-aware aspect, that emits configurations
  # **anytime** at least the `user` data is in context.
  # read more at https://vic.github.io/den/context-aware.html
  den.aspects.setHost =
    { host, ... }:
    {
      networking.hostName = host.hostName;
    };
}
