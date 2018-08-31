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
    pqiv
  ];
  programs.neovim={
    enable = true;
    configure = {
      customRC = ''
      " here your custom configuration goes!
      '';
      
      packages.myVimPackage = with pkgs.vimPlugins; {
        # loaded on launch
        start = [ nerdtree ];
        # manually loadable by calling `:packadd $plugin-name`
        opt = [ ];
      };
      # extraPython3Packages = with pkgs.python3Packages; [ python-language-server ];

    };
  };
  programs.termite.enable = true;
  programs.termite.allowBold = true;
  programs.termite.audibleBell = true;
  programs.termite.backgroundColor = "rgba(55, 00, 30, 0.3)";
  programs.termite.browser = "\${pkgs.xdg_utils}/xdg-open";
  programs.termite.clickableUrl=true;
  programs.termite.cursorShape =  "block"; #s,"ibeam" "underline",
  programs.termite.dynamicTitle = true;
  programs.termite.filterUnmatchedUrls = true;
  programs.termite.cursorColor ="#dcdc00";
  programs.termite.cursorForegroundColor ="#330020";
  programs.termite.foregroundBoldColor = "#b3a400";
  programs.termite.foregroundColor = "#a39400";
  
  programs.termite.highlightColor = "#008855";
  # programs.termite.hintsForegroundColor
  # programs.termite.hintsActiveBackgroundColor
  # programs.termite.hintsActiveForegroundColor
  # programs.termite.hintsBackgroundColor
  # programs.termite.hintsBorderColor
  programs.termite.font = "Source Code Pro 14";
  programs.termite.hintsBorderWidth =  "0.5";
  #programs.termite.hintsFont =  "MigMix 2M";#"Monospace 12";
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
  xdg.enable= true;
  #xdg.configFile= true;
  xsession.enable= false;
  xsession.windowManager.xmonad.enable= false;
  xsession.windowManager.xmonad.enableContribAndExtras= true;
  #xsession.windowManager.command = "${dotfiles}/.xmonad/xmonad-session-rc";

  home.file.".xmonad/xmonad.hs".source = "${dotfiles}/.xmonad/xmonad.hs";
  home.file.".xmonad/xmobarrc.hs".source = "${dotfiles}/.xmonad/xmobarrc.hs";
  home.file.".xmonad/xmonad-session-rc".source = "${dotfiles}/.xmonad/xmonad-session-rc";
  home.file.".config/nixpkgs/config.nix".source = "${dotfiles}/.config/nixpkgs/config.nix";
  # home.file.".config/nixpkgs/home.nix".source = "${dotfiles}/.config/nixpkgs/home.nix";
  home.file.".config/Code/User".source = "${dotfiles}/.config/Code/User";
  home.file.".Xresources".source = "${dotfiles}/Xresources";


#xsession.windowManager.xmonad.config 
}
