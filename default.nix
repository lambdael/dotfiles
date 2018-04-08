with import <nixpkgs> {};
with import <nixhome> { inherit stdenv; inherit pkgs; };
let
  dotfiles = stdenv.mkDerivation {
    name = "lambdael-dotfiles";
    src = /home/lambdael/projects/dotfiles;
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
in
mkHome {
  user = "lambdael";
  files = {
	 ".xmonad/xmonad.hs" = "${dotfiles}/.xmonad/xmonad.hs";
	 ".xmonad/xmobarrc.hs" = "${dotfiles}/.xmonad/xmobarrc.hs";
	 ".xmonad/xmonad-session-rc" = "${dotfiles}/.xmonad/xmonad-session-rc";
	 ".Xresources" = "${dotfiles}/.Xresources";
  };
}
