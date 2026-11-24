#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

TOOLCHAIN="${TOOLCHAIN:-$PWD/../zyc-clang/bin}"
export PATH="$TOOLCHAIN:$PATH"

DEFCONFIG="${DEFCONFIG:-macau_defconfig}"
OUT="${OUT:-out}"

MAKE_ARGS=(
	ARCH=arm
	SUBARCH=arm
	CROSS_COMPILE=arm-linux-gnueabi-
	CLANG_TRIPLE=arm-linux-gnueabi-
	CC=clang
	LD=ld.lld
	AR=llvm-ar
	NM=llvm-nm
	OBJCOPY=llvm-objcopy
	OBJDUMP=llvm-objdump
	STRIP=llvm-strip
	HOSTCC=clang
	HOSTCXX=clang++
	HOSTLD=ld.lld
)

mkdir -p "$OUT"
make O="$OUT" -s "${MAKE_ARGS[@]}" "$DEFCONFIG"
make O="$OUT" -s "${MAKE_ARGS[@]}" -j"$(nproc)"
