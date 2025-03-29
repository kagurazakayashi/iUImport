# PhotoCable

![Icon](icon.png)

[简体中文](README.md) | [繁體中文](README.zh-hant.md) | [English](README.en.md) | [日本語](README.ja.md)

**Easily import photos or videos into iOS albums via cable.**

Transferring photos or videos to your device's album may be a hassle when there is no Internet and LAN connection and only a data cable to connect to your PC. This tool can make you accomplish this task more easily.

## system requirements

- `iOS` ≥ 15.0
- Language: `zh-hans`, `zh-hant`, `ja`, `en`

### Compilation requirements

- `Xcode` ≥ 15.0 (`SwiftUI`)
- `iOS SDK` ≥ 17

## downloading

Since the author does not currently have an Apple developer account, it has not been uploaded to the App Store at this time. Currently it can only be compiled and installed using Xcode.

## Instructions for use

### Windows (computer)

1. Download and install this software.
2. Connect the device to the computer via USB.
3. Open `iTunes` .
4. Clicking on the phone icon button above `iTunes` will take you to your device information page.
5. Click `File Sharing` on the left and select `iUImport`.
6. Drag and drop the picture or video file you want to copy into the file list box.
7. Start this program. If this program has already started, press the Refresh button in the upper right corner to import a new file.

- When importing for the first time, an album permission prompt will pop up, please select `Allow All` in order to write the new file. This program does not contain album reading code.

See official Apple documentation for more connection instructions: [https://support.apple.com/zh-cn/guide/itunes/itns32636/windows](https://support.apple.com/zh-cn/guide/itunes/itns32636/windows)

### macOS

1. Download and install this software.
2. Connect the device to the computer via USB.
3. Open `Finder` .
4. Select your device in the `Finder` left sidebar to go to your device information page.
5. Click `File` above and select `iUImport`.
6. Drag and drop the image or video file you want to copy to the `iUImport` item.
7. Start this program. If this program has already started, press the Refresh button in the upper right corner to import a new file.
8. The program will automatically copy the files you just imported into the album.

- When importing for the first time, an album permission prompt will pop up, please select `Allow All` in order to write the new file. This program does not contain album reading code.

See official Apple documentation for more connection instructions: [https://support.apple.com/zh-cn/guide/mac-help/mchl4bd77d3a/mac](https://support.apple.com/zh-cn/guide/mac-help/mchl4bd77d3a/mac)

## private business

This program will not do any of the following:

- Internet or LAN communication (you can simply select `Don't Allow` if the networking prompt pops up)
- Collect or send your photos or videos to third parties
- charge
- Display Ads
- Read album contents (since the function of this program is only to write)

## LICENSE

Copyright (c) 2024 KagurazakaYashi iUImport is licensed under Mulan PSL v2. You can use this software according to the terms and conditions of the Mulan PSL v2. You may obtain a copy of Mulan PSL v2 at: http://license.coscl.org.cn/MulanPSL2 THIS SOFTWARE IS PROVIDED ON AN “AS IS” BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE. See the Mulan PSL v2 for more details.
