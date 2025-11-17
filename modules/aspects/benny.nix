{
  den,
  lib,
  inputs,
  ...
}:
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
      in
      [
        # from the aspect tree, cooper example is defined below
        den.aspects.setHost
        den._.primary-user
        (<den/user-shell> "fish") # default user shell
      ];

    # Benny configures darwin hosts it lives on.
    darwin =
      { config, ... }:
      {
        imports = [ inputs.nix-homebrew.darwinModules.nix-homebrew ];
        # the above den._.primary-user doesn't work
        system.primaryUser = "benny";

        nix-homebrew = {
          enableRosetta = true;
          user = config.system.primaryUser;
          taps = {
            "homebrew/homebrew-core" = inputs.homebrew-core;
            "homebrew/homebrew-cask" = inputs.homebrew-cask;
          };
          mutableTaps = false;
          autoMigrate = true;
        };
        nix.enable = true;
        nix.extraOptions = ''
          	  experimental-features = nix-command flakes
          	'';

        users.users.benny.home = "/Users/benny";
        system.defaults = {
          dock = {
            autohide = true;
            persistent-apps = [
              "/Applications/Ghostty.app"
              "/Applications/Firefox.app"
              "/System/Applications/Mail.app"
              "/System/Applications/Calendar.app"
            ];
            orientation = "bottom";
            show-recents = false;
            static-only = true;
          };
          finder = {
            FXPreferredViewStyle = "clvm"; # Column view
            # AppleShowAllExtensions = true;
            # FXEnableExtensionChangeWarning = false;
          };
          loginwindow.GuestEnabled = false;
          loginwindow.LoginwindowText = "a6n.in";
          screensaver.askForPasswordDelay = 10;
          NSGlobalDomain = {
            AppleICUForce24HourTime = true;
            KeyRepeat = 1; # Fastest
            InitialKeyRepeat = 15;
          };
        };

        security.pam.services.sudo_local.touchIdAuth = true;

        homebrew = {
          enable = true;
          taps = builtins.attrNames config.nix-homebrew.taps;
          onActivation = {
            autoUpdate = false;
            cleanup = "zap";
            upgrade = true;
          };
          casks = [
            "hammerspoon"
            "firefox"
            "karabiner-elements"
            "tailscale-app"
            "discord"
            "syncthing-app"
            "fastmail"
            "google-chrome"
          ];
          brews = [
            "mas"
            "curl"
          ];
          masApps = {
            "Bitwarden" = 1352778147;
          };
        };
      };

    # Alice home-manager.
    homeManager =
      { pkgs, config, ... }:
      {
        home.packages = with pkgs; [
        ];
        programs = {
          direnv = {
            enable = true;
            nix-direnv.enable = true;
          };
          bat.enable = true;
          btop.enable = true;
          eza.enable = true;
          fd.enable = true;
          fzf.enable = true;
          ripgrep.enable = true;
          zoxide.enable = true;
          neovim.enable = true;
          jujutsu.enable = true;
          zellij = {
            enable = true;
          };
        };
        programs.nh.enable = true;
        programs.home-manager.enable = true;
        xdg.enable = true;

        home.file."${config.home.homeDirectory}/.hammerspoon/init.lua".source =
          ../../resources/home/hammerspoon/init.lua;
        home.file."${config.home.homeDirectory}/.hammerspoon/Spoons/PaperWM.spoon".source =
          ../../resources/home/hammerspoon/Spoons/PaperWM.spoon;
        home.file."${config.home.homeDirectory}/.hammerspoon/Spoons/ActiveSpace.spoon".source =
          ../../resources/home/hammerspoon/Spoons/ActiveSpace.spoon;

        home.activation.reloadHammerspoon = config.lib.dag.entryAfter [ "writeBoundary" ] ''
          $DRY_RUN_CMD /Applications/Hammerspoon.app/Contents/Frameworks/hs/hs -c "hs.reload()"
          $DRY_RUN_CMD sleep 1
          $DRY_RUN_CMD /Applications/Hammerspoon.app/Contents/Frameworks/hs/hs -c "hs.console.clearConsole()"
        '';
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
