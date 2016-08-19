#!/bin/env sh
#### GET-CONFIG ####
SB_PKG="min"
SB_VER="1.4.1"
SB_EXT="tar.gz"
SB_SOURCE="https://github.com/minbrowser/${SB_PKG}/archive/v${SB_VER}.${SB_EXT}"
SB_REPO="https://notabug.org/jayvii/Slackbuilds"
SB_DIR="$1"
#### GET-CONFIG ####

#### DOWNLOAD ####
if [ -z "$SB_DIR" ]; then
	echo "no target directory set."
	echo "\"./${SB_PKG}.get-SB.sh /SOME/TARGET/FOLDER\""
	echo "using \"/tmp/${SB_PKG}-SB/\" instead."
	pause 2
	SB_DIR="/tmp/${SB_PKG}-SB"
fi
mkdir -p "$SB_DIR"
wget -nv "$SB_SOURCE" -O "${SB_DIR}/${SB_PKG}-source.${SB_EXT}"
wget -nv "$SB_REPO/raw/master/Slackbuilds/${SB_PKG}/build/${SB_PKG}.SlackBuild" -O "${SB_DIR}/${SB_PKG}.SlackBuild"
wget -nv "$SB_REPO/raw/master/Slackbuilds/${SB_PKG}/build/${SB_PKG}.desc" -O "${SB_DIR}/${SB_PKG}.desc"
ls -l "$SB_DIR"
#### DOWNLOAD ####
