#!/bin/env sh
#### CONFIG ####
ARCH="$(uname -m)"
case "$ARCH" in
	i?86) SB_ARCH="i386" ;;
	x86_64) SB_ARCH="amd64" ;;
	*) echo "There is no package for your architecture: $(uname -m)." ; exit 1 ;;
esac
SB_PKG="min~bin"
SB_VER="1.4.1"
SB_EXT="deb"
SB_REPO="https://notabug.org/jayvii/Slackbuilds"
SB_DIR="/tmp/${SB_PKG}-${SB_VER}_${SB_ARCH}-SB"
SB_BUILD="$1"
SB_SOURCE="https://github.com/minbrowser/min/releases/download/v${SB_VER}/min_${SB_VER}_${SB_ARCH}.${SB_EXT}"
#### CONFIG ####

echo "Slackbuild for ${SB_PKG}, version ${SB_VER} on ${SB_ARCH} architecture."
echo "=========="

#### DOWNLOAD ####
if [ "${SB_BUILD}" = "build-existing" ]; then
	echo "User claims that Slackbuild and Source already exist in"
	echo "${SB_DIR}"
	echo "Skipping Download!"
	echo "=========="
else
	echo "Downloading..."
	echo "using this Slackbuild-directory:"
	echo "${SB_DIR}"
	echo "=========="
	sleep 2
	mkdir -p "$SB_DIR"
	echo ""
	echo "downloading slackbuild..."
	wget -nv "$SB_REPO/raw/master/Slackbuilds/${SB_PKG}/build/${SB_PKG}.SlackBuild" -O "${SB_DIR}/${SB_PKG}.SlackBuild"
	echo ""
	echo "downloading description..."
	wget -nv "$SB_REPO/raw/master/Slackbuilds/${SB_PKG}/build/${SB_PKG}.desc" -O "${SB_DIR}/${SB_PKG}.desc"
	echo ""
	echo "downloading package-source..."
	wget -nv "$SB_SOURCE" -O "${SB_DIR}/${SB_PKG}-${SB_VER}_${SB_ARCH}-source.${SB_EXT}"
	ls -l "$SB_DIR"
fi
#### DOWNLOAD ####

#### BUILD ####
if [ "${SB_BUILD}" = "build" ] || [ "${SB_BUILD}" = "build-existing" ]; then
	echo "Executing SlackBuild..."
	chmod +x "${SB_DIR}/${SB_PKG}.SlackBuild"
	cd "${SB_DIR}"
	su -c " sh '${SB_PKG}.SlackBuild'" root
else
	echo "Build-parameter not set, so not building."
	echo "If you whish to re-download the source and slackbuild, use the 'build' parameter:"
	echo "./${SB_PKG}.get-SB.sh build"
	echo "If you wish to use the already downloaded source and slackbuild, use the \"build-existing\" parameter:"
	echo "./${SB_PKG}.get-SB.sh build-existing"
	echo "Or simply execute the already downloaded SlackBuild yourself:"
	echo "./${SB_PKG}.SlackBuild"
fi
#### BUILD ####
