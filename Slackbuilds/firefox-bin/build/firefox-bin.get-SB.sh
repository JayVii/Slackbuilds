#!/bin/env sh

#### CONFIG {{{
SB_ARCH="$(uname -m)"
case "$SB_ARCH" in
	i?86) DL_ARCH="i636" ;;
	x86_64) DL_ARCH="x86_64" ;;
	*) echo "There is no package for your architecture: $(uname -m)." ; exit 1 ;;
esac
if [ -z "${SB_LANG}" ]; then
  SB_LANG="en-US"
fi
SB_PKG="firefox-bin"
SB_VER="54.0"
SB_EXT="tar.bz2"
SB_REPO="https://git.jayvii.de/Slackbuilds"
SB_DIR="/tmp/${SB_PKG}-${SB_VER}_${SB_ARCH}-JSB"
SB_BUILD="$1"
SB_SOURCE="https://download-installer.cdn.mozilla.net/pub/firefox/releases/${SB_VER}/linux-${DL_ARCH}/${SB_LANG}/firefox-${SB_VER}.${SB_EXT}"
SB_SHA256="5633734987ee4888ea8f4a052caf7f0c9d7e847949e053baa5ca62d96251bd98"
#### CONFIG }}}

echo "Slackbuild for ${SB_PKG}, version ${SB_VER} on ${SB_ARCH} architecture."
echo "=========="

#### DOWNLOAD {{{
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
echo "Checking SHA2 of package-source..."
SRC_SHA256=$(sha256sum "${SB_DIR}/${SB_PKG}/-${SB_VER}_${SB_ARCH}-source.${SB_EXT}")
if ! [ "${SB_SHA256}" == "${SRC_SHA256}" ]; then
  echo "Source is invalid! Not able to build from this."
  echo "Exiting..."
  exit 1;
else
  echo "Source valid!"
  echo "Continuing..."
fi
#### DOWNLOAD }}}

#### BUILD {{{
if [ "${SB_BUILD}" = "build" ] || [ "${SB_BUILD}" = "build-existing" ]; then
	echo "Executing SlackBuild..."
	chmod +x "${SB_DIR}/${SB_PKG}.SlackBuild"
	cd "${SB_DIR}"
	su -c " sh '${SB_PKG}.SlackBuild'" root
else
	echo "Build-parameter not set, so not building."
	echo "If you whish to re-download the source and slackbuild, use the \"build\" parameter:"
	echo "./${SB_PKG}.get-SB.sh build"
	echo "If you wish to use the already downloaded source and slackbuild, use the \"build-existing\" parameter:"
	echo "./${SB_PKG}.get-SB.sh build-existing"
	echo "Or simply execute the already downloaded SlackBuild yourself:"
	echo "./${SB_PKG}.SlackBuild"
fi
#### BUILD }}}
#EOF
