{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let

    configuration = { pkgs, config, ... }: {

	nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ pkgs.neovim
	  pkgs.mas
	  pkgs.iterm2
	  pkgs.fastfetch
	  pkgs.fzf
	  pkgs.tmux
        ];

	homebrew = {
	  enable = true;
	  brews = [
	  ];
	  casks = [
	    "firefox"
	  ];
	  masApps = {
	    #"Amphetamine" = 937984704;
	  };
	  onActivation.cleanup = "zap";
	  onActivation.autoUpdate = true;
	  onActivation.upgrade = true;
	};

	fonts.packages = with pkgs; [
  	  nerd-fonts.fira-code
  	  nerd-fonts.droid-sans-mono
	  nerd-fonts.jetbrains-mono
  	  nerd-fonts.symbols-only  #This one
	];

	system.activationScripts.applications.text = let
  env = pkgs.buildEnv {
    name = "system-applications";
    paths = config.environment.systemPackages;
    pathsToLink = "/Applications";
  };
in
  pkgs.lib.mkForce ''
  # Set up applications.
  echo "setting up /Applications..." >&2
  sudo find /Applications -user chevirme -group wheel -print0 | xargs -r0 rm -r 
  find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
  while read -r src; do
    app_name=$(basename "$src")
    echo "copying $src" >&2
    /bin/cp -r "$src" "/Applications/$app_name"
    sudo chown chevirme:wheel "/Applications/$app_name"
    sudo chmod 755 "/Applications/$app_name"
    nix-collect-garbage
  done
      '';

	system.defaults = {
	  dock.autohide = true;
	  dock.autohide-delay = 0.0;
	  dock.magnification = true;
	  dock.largesize = 30;
	  dock.mineffect = "scale";
	  dock.minimize-to-application = true;
	  dock.tilesize = 32;
	  dock.wvous-br-corner = 4;
	  #dock.persistent-apps = [
	  #];
	  finder.FXPreferredViewStyle = "Nlsv";
	  finder._FXSortFoldersFirst = true;
	  finder._FXSortFoldersFirstOnDesktop = true;
	  finder.AppleShowAllExtensions = true;
	  finder.AppleShowAllFiles = true;
	  finder.CreateDesktop = false;
	  finder.FXDefaultSearchScope = "SCcf";
	  finder.FXEnableExtensionChangeWarning = false;
	  finder.FXRemoveOldTrashItems = true;
	  finder.NewWindowTarget = "Home";
	  finder.ShowHardDrivesOnDesktop = true;
	  finder.ShowPathbar = true;
	  loginwindow. GuestEnabled = false;
	  NSGlobalDomain.AppleInterfaceStyle = "Dark";
	  NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
	  #NSGlobalDomain."com.apple.trackpad.scaling" = 3;
	  NSGlobalDomain.AppleMeasurementUnits = "Centimeters";
	  NSGlobalDomain.AppleMetricUnits = 1;
	  NSGlobalDomain.AppleShowAllExtensions = true;
	  NSGlobalDomain.AppleTemperatureUnit = "Celsius";
	  NSGlobalDomain.NSDocumentSaveNewDocumentsToCloud = false;
	  NSGlobalDomain.PMPrintingExpandedStateForPrint = true;
	  screencapture.location = "$HOME/Pictures";
	  trackpad.Clicking = true;
	  trackpad.FirstClickThreshold = 2;
	  trackpad.SecondClickThreshold = 2;
	  trackpad.TrackpadThreeFingerDrag = true;
	  WindowManager.EnableStandardClickToShowDesktop = false;
	  WindowManager.EnableTiledWindowMargins = false;
	  WindowManager.HideDesktop = true;
	  WindowManager.StandardHideDesktopIcons = true;
	  ".GlobalPreferences"."com.apple.mouse.scaling" = 0.0;
	  CustomSystemPreferences.NSGlobalDomain."com.apple.mouse.linear" = true;
	  CustomUserPreferences.NSGlobalDomain."com.apple.mouse.linear" = true;
	  controlcenter.BatteryShowPercentage = true;
	};

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      # programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#chevirmes-Virtual-Machine
    darwinConfigurations."chevirmes-Virtual-Machine" = nix-darwin.lib.darwinSystem {
      modules = [ 
      	configuration
      	nix-homebrew.darwinModules.nix-homebrew
	{
	 nix-homebrew = {
	   enable = true;
	   enableRosetta = true;
	   user = "chevirme";
	   autoMigrate = true;
	 };
	}
      ];
    };
  };
}
