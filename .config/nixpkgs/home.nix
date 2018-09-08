# https://github.com/rycee/home-manager
{ pkgs, config, ... }:
with import <nixpkgs> {};
with builtins;
with lib;

let
  dotfiles = stdenv.mkDerivation {
    name = "lambdael-dotfiles";
    src = /home/lambdael/mybook/dotfiles;
/*
    src = fetchgit {
      url = "https://github.com/lambdael/dotfiles.git";
      rev = "9b6d206bfafc29cc8ce0f95fac6bfbbf2d279401";
      sha256 = "0vdpxyac020nlhhcc18cca2753vb85zhi72ncwjg2jrzpwpl62a4";
      fetchSubmodules = true;
    };
*/
    installPhase = ''
      mkdir $out
      cp -a . $out
    '';
  };
  myXmonad = stdenv.mkDerivation {
    name = "lambdael-xmonad";
    src = /home/lambdael/mybook/myXmonad;
    installPhase = ''
      mkdir $out
      cp -a . $out
    '';
  };

in{
  programs.home-manager.enable = true;
  programs.home-manager.path = https://github.com/rycee/home-manager/archive/release-18.03.tar.gz;

  fonts.fontconfig.enableProfileFonts = true;

  #programs.fish.enable  = true;
  #programs.termite.enable = true;
  #gtk.font = 
  #home.keyboard.layout  = "jp106";
  #home.keyboard.model = "jp106";
  home.sessionVariables = {
    VISUAL = "nvim";
    EDITOR = "nvim";
    PAGER = "w3m";
    FOO = "Hello";
    #BAR = "${config.home.sessionVariables.FOO} World!";
  };
  manual.html.enable = true;
  manual.manpages.enable = true;
  home.packages = with pkgs;[
    #pkgs.htop
    termite
    compton
    sqlite
    # pqiv # bg?
    
    
  ];
  programs.fish.enable = false;
  # programs.fish.interactiveShellInit
  programs.fish.loginShellInit = ''
  set -x VISUAL nvim $VISUAL
  set -x EDITOR nvim $EDITOR
  set -x PAGER w3m $PAGER
  env-type () {
    envtype="$1"
    shift
    nix-shell -Q -p $envtype "$@"
  }

  haskell-env () {
    env-type "haskellEnv" "$@"
  }

  haskell-env-hoogle () {
    env-type "haskellEnvHoogle" "$@"
  }
  '';
  # programs.fish.promptInit
  # programs.fish.shellAliases
  # programs.fish.shellInit
  # programs.fish.vendor.completions.enable = true;
  # programs.fish.vendor.config.enable = true;
  # programs.fish.vendor.functions.enable = true;
  programs.neovim={
    enable = true;
    configure = {
       customRC = ''
       " here your custom configuration goes!
       " this is a comment line
       set number
       set list
       set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%

       '';

      packages.myVimPackage = with pkgs.vimPlugins; {
        # loaded on launch
        start = [ 
          nerdtree 
          vim-nix 
          ctrlp
          ctrlp-z 
          # ghcmod-vim
          neco-ghc
         ];
        # manually loadable by calling `:packadd $plugin-name`
        opt = [ ];
      };
      # extraPython3Packages = with pkgs.python3Packages; [ python-language-server ];

    };
  };
  programs.termite={
    enable = true;
    allowBold = true;
    audibleBell = true;
    backgroundColor = "rgba(40, 12, 30, 0.9)";#2b161c
    browser = "\${pkgs.xdg_utils}/xdg-open";
    clickableUrl=true;
    cursorShape =  "block"; # "block" "ibeam" "underline",
    dynamicTitle = true;
    filterUnmatchedUrls = true;
    cursorColor ="#dc33a2";
    cursorForegroundColor ="#330020";
    foregroundBoldColor = "#c39400";
    foregroundColor = "#c39400";
  
    highlightColor = "#aF4399";
    hintsForegroundColor        = "#5555cc";
    hintsActiveBackgroundColor = "#aF4399";
    hintsActiveForegroundColor = "#009955";
    hintsBackgroundColor = "#995999";
    hintsBorderColor = "#336655";
    colorsExtra = ''
# Black, Gray, Silver, White
color0  = #009b96
color8  = #657b83
color7  = #93a1a1
color15 = #ffd6e3


# Red
color1  = #ef4444
color9  = #ec0612

# Green
color2  = #859900
color10 = #85c900

# Yellow
color3  = #ef9f40
color11 = #ef8900

# Blue
color4  = #066bf2
color12 = #368bf2

# Purple
color5  = #8c71c4
color13 = #8c51c4

# Teal
color6  = #3ea198
color14 = #3ac168

# Extra colors
color16 = #cb4b16
color17 = #d33682
color18 = #076682
color19 = #586e75
color20 = #839496
color21 = #eee8d5
  '';
    font = "Source Code Pro 18";
    hintsBorderWidth =  "0.5";
  };
  #  hintsFont =  "MigMix 2M";#"Monospace 12";
  gtk.theme.package = pkgs.gnome3.gnome_themes_standard;
  gtk.theme.name = "Adwaita";
  gtk.enable = true;
  qt.enable= true;
  qt.useGtkTheme= true;
  # services.compton.enable= false;
  # services.compton.blur = true;
  # services.compton.fade = true;
  # services.compton.fadeDelta = 5;
  # services.compton.inactiveOpacity = "0.5";
  # services.compton.shadow = true;
  # services.network-manager-applet.enable= true;
  xdg.enable= false;
  #xdg.configFile= true;
  xsession.enable= false;
  xsession.windowManager.xmonad.enable= false;
  xsession.windowManager.xmonad.enableContribAndExtras= true;
  # xsession.windowManager.command = "${myXmonad}/src/xmonad-session-rc";

  home.file.".xmonad/xmonad.hs".source = "${myXmonad}/src/xmonad.hs";
  home.file.".xmonad/xmobarrc.hs".source = "${myXmonad}/src/xmobarrc.hs";
  home.file.".xmonad/xmonad-session-rc".source = "${myXmonad}/src/xmonad-session-rc";
  home.file.".config/nixpkgs/config.nix".source = "${dotfiles}/.config/nixpkgs/config.nix";
  # home.file.".config/nixpkgs/home.nix".source = "${dotfiles}/.config/nixpkgs/home.nix";
  home.file.".config/Code/User".source = "${dotfiles}/.config/Code/User";
  #home.file.".config/ranger/commands.py".source = "${dotfiles}/.config/ranger/commands.py";
  #home.file.".config/ranger/rc.conf".source = "${dotfiles}/.config/ranger/rc.conf";
  # home.file.".config/ranger/rifle.conf".source = "${dotfiles}/.config/ranger/rifle.conf";
  # home.file.".config/ranger/scope.sh".source = "${dotfiles}/.config/ranger/scope.sh";
  home.file.".Xresources".source = "${dotfiles}/Xresources";


#xsession.windowManager.xmonad.config 
}
