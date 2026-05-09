#
# SPDX-FileCopyrightText: 2024-2026 The LineageOS Project
# SPDX-License-Identifier: Apache-2.0

import common
import os

# Path to the prebuilt vbmeta images (relative to this script)
PREBUILTS_DIR = os.path.join(os.path.dirname(__file__), "prebuilts")

def FullOTA_Assertions(info):
    # LineageOS ASCII logo and build information
    info.script.Print("        _ _  _  _  _  _    _  _  _  _  _    _  _")
    info.script.Print("       (_) || || || || |  | || || || || ||  | || |")
    info.script.Print("       (_) || || || || |  | || || || || ||  | || |")
    info.script.Print("       (_) || || || || |  | || || || || ||  | || |")
    info.script.Print("       (_) _||_||_||_||_  | _||_||_||_||_  | _||_")
    info.script.Print("       (_) |  _         | |  _      _  | | |  _  |")
    info.script.Print("       (_) | | || (_) | || | || (_) | || | | | || |")
    info.script.Print("       (_) | |_||  _ |/ _ | ||  _ |/ _ | | |_|| |")
    info.script.Print("       (_) |  _  | || ||  | || || ||  | |  _  | |")
    info.script.Print("       (_) | | || || ||  | || || ||  | | | || | |")
    info.script.Print("       (_) |_||_||_||_|  |_||_||_||_|  |_|_||_| |")
    info.script.Print("")
    info.script.Print("***********************************************")
    info.script.Print(" ROM version      : LineageOS 21")
    info.script.Print(" Android version  : 14")
    info.script.Print(" Device           : Galaxy A04s (a04s)")
    info.script.Print(" Maintainer       : Michael Owusu Ntim")
    info.script.Print("***********************************************")
    info.script.Print("")

def FullOTA_InstallEnd(info):
    info.script.Print("Patching firmware images...")
    # Read prebuilt vbmeta images directly from the device tree
    AppendImage(info, "vbmeta.img", "/dev/block/by-name/vbmeta")
    AppendImage(info, "vbmeta_system.img", "/dev/block/by-name/vbmeta_system")

def IncrementalOTA_InstallEnd(info):
    FullOTA_InstallEnd(info)

def AppendImage(info, basename, dest):
    # Read the prebuilt image from the device tree's prebuilts folder
    path = os.path.join(PREBUILTS_DIR, basename)
    with open(path, "rb") as f:
        data = f.read()
    # Add the file to the output zip and flash it
    common.ZipWriteStr(info.output_zip, basename, data)
    info.script.AppendExtra('package_extract_file("%s", "%s");' % (basename, dest))