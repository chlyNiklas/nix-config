{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim

  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "schreifuchs";
  home.homeDirectory = "/home/schreifuchs";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.sessionVariables = {
    EDITOR = "nvim";
    
    PIPEWIRE_LATENCY=256/48000;

    DSSI_PATH = "$HOME/.dssi:$HOME/.nix-profile/lib/dssi:/run/current-system/sw/lib/dssi:/etc/profiles/per-user/$USER/lib/dssi";
    LADSPA_PATH = "$HOME/.ladspa:$HOME/.nix-profile/lib/ladspa:/run/current-system/sw/lib/ladspa:/etc/profiles/per-user/$USER/lib/ladspa";
    LV2_PATH = "$HOME/.lv2:$HOME/.nix-profile/lib/lv2:/run/current-system/sw/lib/lv2:/etc/profiles/per-user/$USER/lib/lv2";
    LXVST_PATH = "$HOME/.lxvst:$HOME/.nix-profile/lib/lxvst:/run/current-system/sw/lib/lxvst:/etc/profiles/per-user/$USER/lib/lxvst";
    VST_PATH = "$HOME/.vst:$HOME/.nix-profile/lib/vst:/run/current-system/sw/lib/vst:/etc/profiles/per-user/$USER/lib/vst";
  };
  
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface".color-scheme = "prefer-dark";
      
      "org/gnome/Console".custom-font = "FiraCode Nerd Font Mono 11";

      "org/gnome/desktop/interface".icon-theme = "Papirus-Dark";

      "org/gnome/desktop/sound".event-sound = false;
      "org/gnome/desktop/sound".theme-name = "__custom";

      "org/gnome/shell".favorite-apps = [
        "org.gnome.Calendar.desktop"
        "thunderbird.desktop"
        "brave-browser.desktop" 
        "org.gnome.Console.desktop"
        "org.gnome.Nautilus.desktop"
      ];

      "org/gnome/shell".enabled-extensions = [
        "blur-my-shell@aunetx"
        "gsconnect@andyholmes.github.io"
        "runcat@kolesnikov.se"
        "sp-tray@sp-tray.esenliyim.github.com"
        "gnome-compact-top-bar@metehan-arslan.github.io"
	"tiling-assistant@leleat-on-github"
	"caffeine@patapon.info"
      ];

      "org/gnome/shell/extensions/caffeine".indicator-position-max = 3;

      "org/gnome/mutter".dynamic-workspaces = true;
      "org/gnome/mutter".edge-tiling = false;

      "org/gnome/desktop/peripherals/mouse".speed = -0.62666666666666682;

      "org/gnome/shell/extensions/sp-tray".position = 1;
      "org/gnome/shell/extensions/sp-tray".hidden-when-paused = true;


      "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
	"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
	"/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Control><Alt>t";
        command = "kgx";
        name = "Console";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Control><Alt>e";
        command = "nautilus";
        name = "Nautilus";
      };

    };
  };

  programs.git = {
    enable = true;
    package = pkgs.git;
    userName = "schreifuchs";
    userEmail = "kontakt@schreifuchs.ch";
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "thefuck" ];
      theme = "agnoster";
    };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";

    shellAliases = {
      ll = "ls -l";
      vim = "nvim";
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#default";
    };

    initExtra = "neofetch";
  };

  programs.nixvim = {
    enable = true;

    options = {
      number = true;         # Show line numbers
      relativenumber = true; # Show relative line numbers
      shiftwidth = 2;        # Tab width should be 2
      
    };

    clipboard = {
      register = "unnamedplus";
      providers.wl-copy.enable = true;
    };
    
    plugins = {
      lsp = {
	enable = true;
	servers = {
	  tsserver.enable = true;
	  lua-ls.enable = true;
	  html.enable = true;
	  cssls.enable = true;
	  gopls.enable = true;
	  svelte.enable = true;
	  tailwindcss.enable = true;
	  nixd = {
	    enable = true;
	    autostart = true;
	  };
	};
      };

      cmp.enable = true;
      cmp-buffer.enable = true;
      cmp-nvim-lsp.enable = true;

      treesitter = {
	enable = true;

      };

      autoclose.enable = true;
      lightline.enable = true;
    };

    colorschemes.tokyonight.enable = true;
  };



  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
