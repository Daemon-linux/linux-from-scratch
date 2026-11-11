#!/bin/bash

OUTPUT="/root/base-system-evidence/06-installed-base-system-packages.txt"

declare -A CHECKS=(
    ["Man-pages"]="man"
    ["Iana-Etc"]="/etc/protocols"
    ["Glibc"]="getconf"
    ["Zlib"]="libz.so"
    ["Bzip2"]="bzip2"
    ["Xz"]="xz"
    ["Zstd"]="zstd"
    ["File"]="file"
    ["Readline"]="libreadline.so"
    ["M4"]="m4"
    ["Bc"]="bc"
    ["Flex"]="flex"
    ["Tcl"]="tclsh"
    ["Expect"]="expect"
    ["DejaGNU"]="runtest"
    ["Pkgconf"]="pkgconf"
    ["Binutils"]="ld"
    ["GMP"]="libgmp.so"
    ["MPFR"]="libmpfr.so"
    ["MPC"]="libmpc.so"
    ["Attr"]="setfattr"
    ["Acl"]="setfacl"
    ["Libcap"]="getcap"
    ["Libxcrypt"]="libcrypt.so"
    ["Shadow"]="useradd"
    ["GCC"]="gcc"
    ["Ncurses"]="tic"
    ["Sed"]="sed"
    ["Psmisc"]="pstree"
    ["Gettext"]="gettext"
    ["Bison"]="bison"
    ["Grep"]="grep"
    ["Bash"]="bash"
    ["Libtool"]="libtool"
    ["GDBM"]="libgdbm.so"
    ["Gperf"]="gperf"
    ["Expat"]="xmlwf"
    ["Inetutils"]="ping"
    ["Less"]="less"
    ["Perl"]="perl"
    ["XML::Parser"]="XML/Parser.pm"
    ["Intltool"]="intltoolize"
    ["Autoconf"]="autoconf"
    ["Automake"]="automake"
    ["OpenSSL"]="openssl"
    ["Libelf"]="eu-readelf"
    ["Libffi"]="libffi.so"
    ["Python"]="python3"
    ["Flit-Core"]="flit"
    ["Packaging"]="packaging"
    ["Wheel"]="wheel"
    ["Setuptools"]="easy_install"
    ["Ninja"]="ninja"
    ["Meson"]="meson"
    ["Kmod"]="modprobe"
    ["Coreutils"]="ls"
    ["Check"]="libcheck.so"
    ["Diffutils"]="diff"
    ["Gawk"]="gawk"
    ["Findutils"]="find"
    ["Groff"]="groff"
    ["GRUB"]="grub-install"
    ["Gzip"]="gzip"
    ["IPRoute2"]="ip"
    ["Kbd"]="loadkeys"
    ["Libpipeline"]="libpipeline.so"
    ["Make"]="make"
    ["Patch"]="patch"
    ["Tar"]="tar"
    ["Texinfo"]="makeinfo"
    ["Vim"]="vim"
    ["MarkupSafe"]="markupsafe"
    ["Jinja2"]="jinja2"
    ["Systemd"]="systemctl"
    ["D-Bus"]="dbus-daemon"
    ["Man-DB"]="mandb"
    ["Procps-ng"]="ps"
    ["Util-linux"]="mount"
    ["E2fsprogs"]="e2fsck"
    ["Sysklogd"]="syslogd"
    ["SysVinit"]="init"
)

has_item() {
    local item="$1"

    if [[ "$item" == /* ]]; then
        [[ -e "$item" ]]
    elif [[ "$item" == */* ]]; then
        [[ -e "/usr/$item" ]]
    else
        command -v "$item" >/dev/null 2>&1 ||
        find /usr/lib /usr/lib64 \
            -maxdepth 1 -name "$item" \
            -print -quit 2>/dev/null | grep -q .
    fi
}

packages=(
    "Man-pages" "Iana-Etc" "Glibc" "Zlib" "Bzip2" "Xz" "Zstd"
    "File" "Readline" "M4" "Bc" "Flex" "Tcl" "Expect" "DejaGNU"
    "Pkgconf" "Binutils" "GMP" "MPFR" "MPC" "Attr" "Acl" "Libcap"
    "Libxcrypt" "Shadow" "GCC" "Ncurses" "Sed" "Psmisc" "Gettext"
    "Bison" "Grep" "Bash" "Libtool" "GDBM" "Gperf" "Expat"
    "Inetutils" "Less" "Perl" "XML::Parser" "Intltool" "Autoconf"
    "Automake" "OpenSSL" "Libelf" "Libffi" "Python" "Flit-Core"
    "Packaging" "Wheel" "Setuptools" "Ninja" "Meson" "Kmod"
    "Coreutils" "Check" "Diffutils" "Gawk" "Findutils" "Groff"
    "GRUB" "Gzip" "IPRoute2" "Kbd" "Libpipeline" "Make" "Patch"
    "Tar" "Texinfo" "Vim" "MarkupSafe" "Jinja2" "Systemd" "D-Bus"
    "Man-DB" "Procps-ng" "Util-linux" "E2fsprogs" "Sysklogd" "SysVinit"
)

mkdir -p "$(dirname "$OUTPUT")"

{
    echo "Linux From Scratch 13.1-systemd"
    echo "Base System Package Presence Report"
    echo
    echo "Architecture: $(uname -m)"
    echo "Target: $(gcc -dumpmachine 2>/dev/null || echo Unknown)"
    echo "Check type: Command and file presence"
    echo
    echo "=================================================="
    echo "PACKAGE CHECKLIST"
    echo "=================================================="
    echo

    installed=0
    missing=0

    for package in "${packages[@]}"; do
        probe="${CHECKS[$package]}"

        if has_item "$probe"; then
            printf '[✓] %s\n' "$package"
            ((installed += 1))
        else
            printf '[ ] %s\n' "$package"
            ((missing += 1))
        fi
    done

    echo
    echo "=================================================="
    echo "FINAL STATUS"
    echo "=================================================="
    echo
    echo "Total packages checked: ${#packages[@]}"
    echo "Presence confirmed: $installed"
    echo "Not detected: $missing"
    echo
    echo "Note: Presence checks do not prove package test-suite success."
} > "$OUTPUT"

cat "$OUTPUT"
