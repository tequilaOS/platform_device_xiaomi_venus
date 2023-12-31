#!/bin/bash
#
# Copyright (C) 2020 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

function blob_fixup() {
    case "${1}" in
    vendor/etc/camera/pureShot_parameter.xml)
        sed -i 's/=\([0-9]\+\)>/="\1">/g' "${2}"
        ;;
    vendor/lib64/hw/camera.qcom.so)
        sed -i "s/\x73\x74\x5F\x6C\x69\x63\x65\x6E\x73\x65\x2E\x6C\x69\x63/\x63\x61\x6D\x65\x72\x61\x5F\x63\x6E\x66\x2E\x74\x78\x74/g" "${2}"
        ;;
    vendor/lib64/hw/camera.xiaomi.so)
	"${SIGSCAN}" -p "AA 06 00 94" -P "1F 20 03 D5" -f "${2}"
        ;;
    vendor/lib64/vendor.qti.hardware.camera.postproc@1.0-service-impl.so)
        "${SIGSCAN}" -p "8D 0A 00 94" -P "1F 20 03 D5" -f "${2}"
        ;;
     vendor/lib64/vendor.xiaomi.hardware.cameraperf@1.0-impl.so)
        "${SIGSCAN}" -p "7C 00 00 94" -P "1F 20 03 D5" -f "${2}"
        ;;
    esac
}

# If we're being sourced by the common script that we called,
# stop right here. No need to go down the rabbit hole.
if [ "${BASH_SOURCE[0]}" != "${0}" ]; then
    return
fi

set -e

# Required!
export DEVICE=venus
export DEVICE_COMMON=sm8350-common
export VENDOR=xiaomi

"./../../${VENDOR}/${DEVICE_COMMON}/extract-files.sh" "$@"
