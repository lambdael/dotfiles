#!/usr/bin/env sh



# ${0} の dirname を取得
cwd=`dirname "${0}"`

# ${0} が 相対パスの場合は cd して pwd を取得
expr "${0}" : "/.*" > /dev/null || cwd=`(cd "${cwd}" && pwd)`

sourceDir="${cwd}/.config/nixpkgs/"
targetDir="/etc/"
cfgSrcPath="${sourceDir}home.nix"
cfgTgtPath="/home/lambdael/.config/nixpkgs/home.nix"

# echo "copy"
# echo "FROM $sourceDir"
# echo "TO   /etc/"
# sudo cp -r $sourceDir /etc/

# echo "HOSTNAME $HOSTNAME"

if [ ! -e $cfgSrcPath ]; then
  cfgSrcPath="${sourceDir}home.nix"
fi
echo "copy"
echo "FROM $cfgSrcPath"
echo "TO   $cfgTgtPath"

cp -pr $cfgSrcPath $cfgTgtPath 


echo "rebuild"
home-manager switch --show-trace


