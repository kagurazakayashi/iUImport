# iUImport

![Icon](icon.png)

[简体中文](README.md) | [繁體中文](README.zh-hant.md) | [English](README.en.md) | [日本語](README.ja.md)

**Easily import photos or videos to iOS photo album via data cable.**

If there is no Internet or LAN connection, and only a data cable is connected to the computer, transferring specified photos or videos to the photo album of the iOS device is a troublesome task. This tool makes it easier for you to do this.

## System Requirements

- `iOS` ≥ 15.0
- Language: `zh-hans`, `zh-hant`, `ja`, `en`

### Compilation requirements

- `Xcode` ≥ 15.0 (`SwiftUI`)
- `iOS SDK` ≥ 17

## download

Since the author currently does not have an Apple developer account, it has not been uploaded to the App Store yet. Currently it can only be compiled and installed using Xcode.

## Instructions for use

### Windows

0. Download and install this software.
1. Connect the device to the computer via USB.
2. Open `iTunes`.
3. Click the phone icon button above `iTunes` and you will see your device information page.
4. Click `File Sharing` on the left and select `iUImport`.
5. Drag the image or video file you want to copy to the file list box.
6. Start this program. If the program is already started, press the refresh button in the upper right corner to import new files.

- When importing for the first time, an album permission prompt will pop up, please select `Allow all` to write new files. This program does not contain photo album reading code.

For more connection instructions, please refer to Apple’s official documentation:
<https://support.apple.com/zh-cn/guide/itunes/itns32636/windows>

### macOS

0. Download and install this software.
1. Connect the device to the computer via USB.
2. Open `Finder`.
3. Select your device in the left column of `Finder` to enter your device information page.
4. Click `File` above and select `iUImport`.
5. Drag the image or video file you want to copy to the `iUImport` item.
6. Start this program. If the program is already started, press the refresh button in the upper right corner to import new files.
7. The program will automatically copy the file just imported to the album.

- When importing for the first time, an album permission prompt will pop up, please select `Allow all` to write new files. This program does not contain photo album reading code.

For more connection instructions, please refer to Apple’s official documentation:
<https://support.apple.com/zh-cn/guide/mac-help/mchl4bd77d3a/mac>

## privacy

This program will not do any of the following:

- Internet or LAN communication (if a networking prompt pops up, you can directly select `Not Allowed`)
- Collect or send your photos or videos to third parties
- Fee
- Display ads
- Read the contents of the album (because the function of this program is only writing)

## LICENSE

Copyright (c) 2024 KagurazakaYashi iUImport is licensed under Mulan PSL v2. You can use this software according to the terms and conditions of the Mulan PSL v2. You may obtain a copy of Mulan PSL v2 at: http://license.coscl.org.cn/MulanPSL2 THIS SOFTWARE IS PROVIDED ON AN “AS IS” BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE. See the Mulan PSL v2 for more details.
