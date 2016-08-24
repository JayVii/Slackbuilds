#!/bin/env sh
#### CONFIG ####
SB_PKG="min~bin"
SB_VER="1.4.1"
SB_EXT="tar.gz"
SB_SOURCE="https://github.com/minbrowser/${SB_PKG}/archive/v${SB_VER}.${SB_EXT}"
SB_REPO="https://notabug.org/jayvii/Slackbuilds"
SB_DIR="/tmp/${SB_PKG}-SB"
SB_BUILD="$1"
#### CONFIG ####

echo "Slackbuild for ${SB_PKG}, version ${SB_VER}"
echo "=========="
echo ""

#### DOWNLOAD ####
if [ ${SB_BUILD} = "build-existing" ]; then
	echo "User claims that Slackbuild and Source already exist in"
	echo "\"/tmp/${SB_PKG}-SB/\""
	echo "Skipping Download!"
else
	echo "Downloading..."
	echo "using this Slackbuild-directory: \"/tmp/${SB_PKG}-SB/\"."
	pause 2
	mkdir -p "$SB_DIR"
	wget -nv "$SB_REPO/raw/master/Slackbuilds/${SB_PKG}/build/${SB_PKG}.SlackBuild" -O "${SB_DIR}/${SB_PKG}.SlackBuild"
	wget -nv "$SB_REPO/raw/master/Slackbuilds/${SB_PKG}/build/${SB_PKG}.desc" -O "${SB_DIR}/${SB_PKG}.desc"
	wget -nv "$SB_SOURCE" -O "${SB_DIR}/${SB_PKG}-source.${SB_EXT}"
	ls -l "$SB_DIR"
fi
#### DOWNLOAD ####

#### BUILD ####
if [ ${SB_BUILD} = "build" ] || [ ${SB_BUILD} = "build-existing" ]; then
	echo "Executing SlackBuild..."
	cd ${SB_DIR}
	sh -c ${SB_PKG}.SlackBuild
else
	echo "Build-parameter not set, so not building."
	echo "If you whish to re-download the source and slackbuild, use the \"build\" parameter:"
	echo "\"./${SB_PKG}.get-SB.sh build\""
	echo "If you wish to use the already downloaded source and slackbuild, use the \"build-existing\" parameter:"
	echo "\"./${SB_PKG}.get-SB.sh build-existing\""
	echo "Or simply execute the already downloaded SlackBuild yourself:"
	echo "\"./${SB_PKG}.SlackBuild\""
fi
#### BUILD ####
