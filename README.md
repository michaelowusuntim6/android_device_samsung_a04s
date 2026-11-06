# Samsung Galaxy A04s (SM-A047F) — LineageOS 23.2 Device Tree

LineageOS 23.2 device configuration for the Samsung Galaxy A04s, codename **`a04s`**, based on the Samsung Exynos 850 platform (`universal3830` / `exynos850`).

| Property | Value |
|---|---|
| Device | Samsung Galaxy A04s |
| Model | SM-A047F |
| Codename | `a04s` |
| SoC | Samsung Exynos 850 (Exynos 3830) |
| Platform | `universal3830` |
| Target | LineageOS 23.2 (Android 16) |
| Branch | `a04s-port` |
| License | Apache License 2.0 |

---

## Status

This is an **in-development port**. The device tree compiles as part of a LineageOS 23.2 source tree and the device-specific components have been reviewed and repaired, but **a full LineageOS build has not been validated in this repository's current state, and successful booting of LineageOS on the device is not claimed**.

The physical device used during development currently runs Samsung OneUI 6.1 Core (Android 14) with a custom KernelSU-Next boot image. All statements below distinguish:

- what has been verified offline (DTS/DTBO compilation and structural validation),
- what has been verified on the device only for the stock/OneUI environment,
- what remains untested (a LineageOS ROM build and a LineageOS boot).

---

## Related repositories

The device tree is one of three independent repositories:

| Repository | Path in a Lineage checkout | Purpose |
|---|---|---|
| `android_device_samsung_a04s` (this repository) | `device/samsung/a04s` | Device configuration, board/product makefiles, DTBO/DTS selection, init/fstab, sepolicy, shims, overlays |
| `android_kernel_samsung_a04s` | `kernel/samsung/a04s` | Linux 4.19.325 kernel with Samsung Exynos 850 support, KernelSU-Next and SUSFS, a04s DTS overlays |
| `android_vendor_samsung_a04s` | `vendor/samsung/a04s` | Proprietary blobs extracted from Samsung firmware |

Additional Samsung/Lineage dependencies are declared in [`lineage.dependencies`](lineage.dependencies) (Samsung SLSI hardware, Exynos graphics/audio/OpenMAX, Samsung and Lineage sepolicy, and the SCSC Wi-Fi/BT stack).

---

## Repository layout

| Path | Purpose |
|---|---|
| `AndroidProducts.mk` | Declares `lineage_a04s.mk` as the product makefile |
| `lineage_a04s.mk` | Product definition (`lineage_a04s`), inherits the device makefile and Lineage common phone config |
| `device.mk` | Device packages, HALs, configuration files, kernel/DTBO wiring, properties |
| `BoardConfig.mk` | Board configuration: architecture, boot image, partitions, dynamic partitions, AVB, kernel/DTB/DTBO selection |
| `Android.bp` | Soong definitions for device-local modules |
| `configs/` | Runtime configuration (see below) |
| `init/` | Device init library (`init_exynos3830.cpp`) |
| `sepolicy/vendor/` | Device-specific vendor SELinux policy |
| `shims/` | Compatibility shims for vendor binaries (libutils v32, libcrypto, camera, sensors, DSMS, idiv0) |
| `vndk/` | 32-bit VNDK prebuilt shims (`libutils-v31`, `libhidlbase-v31`, `libbinder-v31`) |
| `audio/`, `touch/` | Device audio proxy and touch sysinput service sources |
| `overlay/`, `rro_overlays/` | Framework resource overlays (including `WifiOverlay`) |
| `recovery/` | Recovery updater extension (`librecovery_updater_exynos850`) |
| `releasetools/` | OTA installation extensions |
| `manifest.xml`, `compatibility_matrix.xml` | Device VINTF manifest and compatibility matrix |
| `vendor.prop` | Device vendor properties |
| `proprietary-files.txt` | Blob list used to populate the vendor repository |
| `extract-files.py`, `setup-makefiles.py` | Helpers for extracting and wiring vendor blobs |
| `board-info.txt` | Board information consumed by the build |
| `LICENSE` | Apache License 2.0 |

### `configs/`

| Path | Purpose |
|---|---|
| `configs/kernel/a04s.cfg` | DTBO image configuration: overlay list and hardware-revision match fields |
| `configs/kernel/exynos850.cfg` | Base DTB image configuration (`exynos3830.dtb`) |
| `configs/init/fstab.exynos850` | Fstab used by both normal boot and recovery |
| `configs/init/init.exynos850.rc` | Main device/vendor init script |
| `configs/init/init.exynos850.usb.rc` | USB init script |
| `configs/init/init.recovery.exynos850.rc` | Recovery init script |
| `configs/init/ueventd.rc` | ueventd rules |
| `configs/audio/`, `configs/media/`, `configs/mixer/` | Audio policy/effects/media/mixer configuration |
| `configs/power/`, `configs/thermal/`, `configs/sensors/` | Power hints, thermal config, sensor HAL list |
| `configs/ril/`, `configs/wifi/`, `configs/linker/` | RIL, Wi-Fi and linker configuration |

---

## Product and board configuration

- **Product:** `lineage_a04s` — 64-bit, non-A/B, `PRODUCT_SHIPPING_API_LEVEL := 31`, model `SM-A047F`.
- **Architecture:** `arm64` primary, `arm` secondary (generic armv8-a CPU variants).
- **Boot image:** header version 2, 2048-byte pages, base `0x10000000`, kernel offset `0x8000`, ramdisk offset `0x01000000`, tags `0x100`, DTB offset `0`; DTB included in the boot image.
- **Partitions:** boot `46137344`, recovery `55574528`, cache `209715200`, DTBO `8388608`, super `6845104128` with a `6840909824` `samsung_dynamic_partitions` group containing `system`, `system_ext`, `vendor`, `product`, `odm`.
- **Filesystems:** ext4 for the dynamic images and cache (F2FS support is enabled).
- **AVB:** enabled, vbmeta flags `3` (verity and verification disabled), algorithm `NONE`, recovery chain `SHA256_RSA4096` with the AOSP test key.
- **Kernel wiring:** `TARGET_KERNEL_SOURCE := kernel/samsung/a04s`, `TARGET_KERNEL_CONFIG := exynos850-a04sxx_defconfig`, Clang-only compilation (`TARGET_KERNEL_CLANG_COMPILE := true`, `TARGET_KERNEL_NO_GCC := true`).
- **DTB:** `BOARD_DTB_CFG := configs/kernel/exynos850.cfg` selects `exynos3830.dtb`.
- **DTBO:** `BOARD_KERNEL_SEPARATED_DTBO := true`, `BOARD_DTBO_CFG := configs/kernel/a04s.cfg`; the recovery image embeds the same DTBO table (`BOARD_INCLUDE_RECOVERY_DTBO := true`).

> Note: the `BOARD_KERNEL_CMDLINE` entries in `BoardConfig.mk` include `androidboot.dtbo_idx=5` and `androidboot.selinux=permissive`. On this Samsung bootloader the boot-image header command line is **not** forwarded to the kernel; the effective command line is composed from bootloader arguments and the DTB `chosen/bootargs`. These two entries therefore do not control the live system. See *Known limitations*.

---

## Hardware revisions and the DTBO architecture

The A04s boot chain uses a single base DTB plus a set of revision-specific DTBO overlays:

- **Base DTB:** `exynos3830.dtb`, built from `arch/arm64/boot/dts/exynos/exynos3830.dts` in the kernel repository. It carries `dtb-hw_rev = 0x00` and `dtb-hw_rev_end = 0xff`.
- **Overlays:** six overlays built from `arch/arm64/boot/dts/samsung/a04s/a04s_eur_open_w00_r00.dts` … `r05.dts` in the kernel repository:

  | Index | Overlay | Hardware revision range (DTS) | Model string |
  |---:|---|---|---|
  | 0 | `a04s_eur_open_w00_r00.dtbo` | `dtbo-hw_rev 0x00` – `0x00` | Samsung A04S EUR OPEN 00 |
  | 1 | `a04s_eur_open_w00_r01.dtbo` | `0x01` – `0x01` | Samsung A04S EUR OPEN 01 |
  | 2 | `a04s_eur_open_w00_r02.dtbo` | `0x02` – `0x02` | Samsung A04S EUR OPEN REV02B |
  | 3 | `a04s_eur_open_w00_r03.dtbo` | `0x03` – `0x03` | Samsung A04S EUR OPEN REV02C |
  | 4 | `a04s_eur_open_w00_r04.dtbo` | `0x04` – `0x04` | Samsung A04S EUR OPEN REV03 |
  | 5 | `a04s_eur_open_w00_r05.dtbo` | `0x05` – `0x20` | Samsung A04S EUR OPEN REV03C |

- **Matching:** `configs/kernel/a04s.cfg` writes the revision range into each DTBO table entry:
  - `custom0` must equal the overlay's `dtbo-hw_rev`;
  - `custom1` must equal the overlay's `dtbo-hw_rev_end`.

  The bootloader compares these fields against the SoC hardware revision and applies the matching overlay. The SM-A047F unit used during development is **REV03C**, which maps to index 5 (`custom0 = 0x00000005`, `custom1 = 0x00000020`).

The DTBO image is generated from `a04s.cfg` with `mkdtboimg.py cfg_create` by the kernel/Lineage build integration. The base DTB image is generated from `exynos850.cfg`.

---

## Build integration

The device tree is built as part of a LineageOS 23.2 source tree:

```bash
source build/envsetup.sh
breakfast lineage_a04s        # or: lunch lineage_a04s-userdebug
m bootimage dtboimage         # image targets
```

The kernel is built by the Lineage kernel integration from `TARGET_KERNEL_SOURCE` / `TARGET_KERNEL_CONFIG`; the DTBO and base DTB are produced from the kernel DTS sources using the configs in this repository.

**These commands are the standard LineageOS workflow and were not executed as part of preparing this repository.** No `out/` directory exists in the development checkout, and no full ROM build is claimed. A complete build requires the matching vendor repository and the Samsung/Lineage dependencies listed in `lineage.dependencies`.

Vendor blobs are populated from `proprietary-files.txt` using `extract-files.py` / `setup-makefiles.py` and are kept in the separate vendor repository.

---

## Repair history

### Phase 4 — DTBO hardware revision correction (2026-11-06)

`configs/kernel/a04s.cfg` previously stored the revision match values shifted left by 24 bits (`0x01000000`, `0x02000000`, … `0x05000000` / `0x20000000`). The bootloader could therefore not match hardware revision 5 and fell back to overlay 0 (`EUR OPEN 00`) instead of overlay 5 (`REV03C`).

The file now contains the correct values:

| Overlay | custom0 | custom1 |
|---|---:|---:|
| r00 | `0x00000000` | `0x00000000` |
| r01 | `0x00000001` | `0x00000001` |
| r02 | `0x00000002` | `0x00000002` |
| r03 | `0x00000003` | `0x00000003` |
| r04 | `0x00000004` | `0x00000004` |
| r05 | `0x00000005` | `0x00000020` |

### Kernel-side overlay repair

The six a04s overlay DTS files in the kernel repository (`android_kernel_samsung_a04s`, path `arch/arm64/boot/dts/samsung/a04s/`) contained 24 malformed octal escapes each (`\02000`, `\060`, `\05000`, …) inside panel action strings. Those were corrected to explicit `\000` NUL escapes as part of the same Phase 4 work; that change is committed in the kernel repository, not here.

---

## Validation performed so far

Offline, outside the Android build system:

- All six corrected overlay DTS files compiled successfully with `cpp` + `dtc` using the kernel's DTS flags.
- All panel action-list properties in every compiled overlay were verified byte-for-byte against the stock Samsung DEYL1 overlays.
- A DTBO image was generated with `mkdtboimg.py` and its table parsed independently: six entries, correct `custom0`/`custom1`, index 5 containing the `REV03C` model.
- The base DTB compiled and its FDT was byte-for-byte identical to the DTB embedded in the existing Lineage boot image.
- `git diff --check` was clean.

**Not performed / not claimed:** no Android build-system target, no kernel build, no full ROM build, and no LineageOS boot test on the device. The regenerated DTBO is structurally valid but has not been proven bootable.

---

## Known limitations and open issues

1. **No LineageOS boot validation.** The device has not been observed booting LineageOS successfully. Do not treat any image from this tree as boot-tested.
2. **Boot-image command line is ignored by this bootloader.** `androidboot.selinux=permissive` and `androidboot.dtbo_idx=5` in `BoardConfig.mk` do not reach the kernel; the bootloader supplies its own arguments plus the DTB `chosen/bootargs`.
3. **SELinux policy completeness.** The device tree ships 50 vendor policy files; the stock Samsung vendor policy is not carried over. Enforcing-mode boot behaviour is untested.
4. **Android 16 / Android 14 vendor compatibility.** The vendor blobs are from Android 14 (VNDK 34, VINTF target-level 6); their behaviour under Android 16 is not verified.
5. **Regenerated DTBO parity.** The source-generated overlays are not byte-identical to Samsung's shipped DEYL1 overlays outside the panel lists (battery/abox tuning inherited from the kernel DTS). The known-good testing reference is the stock DEYL1 DTBO, not the regenerated image.
6. **`/data` / `/metadata` encryption state.** Formatting and metadata-encryption chronology after a ROM switch is unresolved.
7. **Init script divergence.** The device `init.exynos850.rc` differs substantially from the stock vendor file; functional impact is untested.
8. **Kernel base.** The Lineage kernel is 4.19.325 while Samsung's factory kernel is 4.19.198; driver-level regressions cannot be excluded without a boot test.

---

## License

Device-tree sources in this repository are licensed under the Apache License 2.0 (`LICENSE`), except where a file states otherwise. Kernel sources are licensed under GPL-2.0 in the kernel repository.
