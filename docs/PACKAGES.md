# Termux Package List

This file documents all packages installed by `install.sh` via `packages.txt`.

To install all packages:

```bash
pkg install $(cat packages.txt | tr '\n' ' ')
```

## Packages

| Package | Description |
|---------|-------------|
| `apt` | Package manager |
| `bash` | GNU Bourne Again SHell |
| `bzip2` | High-quality block-sorting file compressor |
| `ca-certificates` | Common CA certificates |
| `clamav` | Antivirus engine for detecting malicious code |
| `clamav-static` | Static binaries for ClamAV |
| `clang` | C, C++, and Objective-C compiler |
| `cmake` | Cross-platform build system |
| `command-not-found` | Suggests packages for missing commands |
| `coreutils` | Basic GNU file, shell and text utilities |
| `curl` | Transfer data with URLs |
| `dash` | POSIX-compliant shell, smaller than bash |
| `debianutils` | Miscellaneous utilities from Debian |
| `dialog` | Display dialog boxes from shell scripts |
| `diffutils` | File comparison utilities |
| `dnsutils` | DNS lookup utilities (dig, nslookup) |
| `dos2unix` | DOS/Mac to UNIX text file format converter |
| `dpkg` | Debian package manager |
| `ed` | Classic line editor |
| `ffmpeg` | Audio/video encoder, decoder, and transcoder |
| `findutils` | GNU find, xargs, and locate |
| `gawk` | GNU implementation of AWK |
| `gh` | GitHub CLI |
| `git` | Distributed version control system |
| `gpgv` | GNU privacy guard - signature verification tool |
| `graphviz` | Graph visualization tools |
| `grep` | Print lines matching a pattern |
| `gzip` | GNU compression utility |
| `harfbuzz` | Text shaping engine |
| `htop` | Interactive process viewer |
| `imagemagick` | Image manipulation tools |
| `inetutils` | Network utilities (ftp, telnet, etc.) |
| `jsoncpp` | JSON parsing library for C++ |
| `less` | File pager |
| `libandroid-glob` | Android glob library |
| `libandroid-spawn` | Android process spawn library |
| `libandroid-support` | Android support library |
| `libarchive` | Multi-format archive library |
| `libassuan` | IPC library for GnuPG |
| `libbz2` | bzip2 compression library |
| `libc++` | LLVM C++ standard library |
| `libcap-ng` | POSIX capabilities library |
| `libcurl` | Multi-protocol file transfer library |
| `libdrm` | Direct Rendering Manager library |
| `libevent` | Asynchronous event notification library |
| `libexpat` | XML parsing library |
| `libffi` | Foreign function interface library |
| `libgcrypt` | GNU cryptography library |
| `libgmp` | GNU Multiple Precision arithmetic library |
| `libgnutls` | GNU TLS library |
| `libgpg-error` | GnuPG error codes library |
| `libheif` | HEIF and AVIF file format library |
| `libiconv` | Character encoding conversion library |
| `libidn2` | Internationalized domain names library |
| `liblz4` | LZ4 compression library |
| `liblzma` | LZMA compression library |
| `libmd` | Message Digest library |
| `libmpfr` | Arbitrary-precision floating-point library |
| `libnettle` | Cryptographic library |
| `libnghttp2` | HTTP/2 library |
| `libnghttp3` | HTTP/3 library |
| `libngtcp2` | QUIC protocol library |
| `libnpth` | New GNU Portable Threads library |
| `libpng` | PNG image format library |
| `libsmartcols` | Smart column output library |
| `libsodium` | Modern cryptography library |
| `libsrt` | Secure Reliable Transport library |
| `libssh2` | SSH2 protocol library |
| `libtirpc` | Transport Independent RPC library |
| `libunbound` | DNS resolver library |
| `libunistring` | Unicode string library |
| `libx265` | H.265/HEVC encoder library |
| `libxml2` | XML parsing library |
| `littlecms` | Color management library |
| `lsof` | List open files |
| `make` | GNU make build tool |
| `mesa-vulkan-icd-swrast` | Mesa software Vulkan driver |
| `nano` | Small and friendly text editor |
| `ncurses` | Terminal UI library |
| `net-tools` | Network configuration tools (ifconfig, netstat) |
| `nodejs` | JavaScript runtime |
| `npm` | Node.js package manager |
| `openssh` | SSH client and server |
| `openssh-sftp-server` | SFTP subsystem for OpenSSH |
| `openssl` | TLS/SSL toolkit |
| `openssl-tool` | OpenSSL command-line tool |
| `p7zip` | 7-Zip file archiver |
| `patch` | Apply patches to files |
| `pcre2` | Perl Compatible Regular Expressions library v2 |
| `pkg-config` | Compile flags helper for libraries |
| `procps` | Process monitoring utilities (ps, top, free) |
| `proot-distro` | Linux distribution management for Termux |
| `psmisc` | Process utilities (killall, pstree) |
| `python` | Python 3 interpreter |
| `python-pip` | Python package installer |
| `rclone` | Cloud storage sync tool |
| `readline` | GNU readline library |
| `resolv-conf` | DNS resolver configuration |
| `ripgrep` | Fast recursive search tool (rg) |
| `rust` | Rust programming language toolchain |
| `sed` | Stream editor |
| `shaderc` | GLSL to SPIR-V compiler |
| `tar` | GNU tape archiver |
| `termux-am` | Termux Android am command wrapper |
| `termux-am-socket` | Termux Android am socket |
| `termux-exec` | Termux exec hook |
| `termux-keyring` | Termux signing keys |
| `termux-licenses` | Termux license files |
| `termux-tools` | Termux base utilities |
| `tmux` | Terminal multiplexer |
| `traceroute` | Network path tracing utility |
| `unrar` | RAR archive extractor |
| `unzip` | ZIP archive extractor |
| `util-linux` | Linux system utilities |
| `vim` | Improved vi text editor |
| `vulkan-headers` | Vulkan API headers |
| `vulkan-loader-generic` | Generic Vulkan loader |
| `vulkan-tools` | Vulkan utilities and tools |
| `wget` | Non-interactive network downloader |
| `whois` | WHOIS client |
| `x11-repo` | Termux X11 repository |
| `xxd` | Hex dump utility |
| `xxhash` | Extremely fast hashing library |
| `xz-utils` | XZ compression utilities |
| `zlib` | Compression library |
| `zsh` | Z shell |
| `zstd` | Zstandard compression |

## Adding a New Package

1. Install the package: `pkg install <package-name>`
2. Add it to `packages.txt` (keep the list sorted alphabetically).
3. Document it in this file with a short description.
4. Commit with `chore: add <package-name> to packages`.
