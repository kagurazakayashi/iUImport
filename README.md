# iUImport

![Icon](icon.png)

[简体中文](README.md) | [繁體中文](README.zh-hant.md) | [English](README.en.md) | [日本語](README.ja.md)

**通过数据线将照片或视频轻松导入到 iOS 相册中。**

如果没有互联网和局域网连接、只有数据线连接电脑时，向 iOS 设备的相册中传输指定的照片或视频是一件麻烦的事情。这个工具可以让你更轻松的完成这项事务。

## 系统要求

- `iOS` ≥ 15.0
- Language: `zh-hans`, `zh-hant`, `ja`, `en`

### 编译要求

- `Xcode` ≥ 15.0 (`SwiftUI`)
- `iOS SDK` ≥ 17

## 下载

由于作者目前没有苹果开发者账户，暂时没有上传到应用商店。目前只能够使用 Xcode 编译安装。

## 使用说明

### Windows

0. 下载和安装本软件。
1. 将设备通过 USB 连接到计算机。
2. 打开 `iTunes` 。
3. 单击 `iTunes` 上方的手机图标按钮，将能看到你的设备信息页面。
4. 单击左侧的 `文件共享` ，选择 `iUImport` 。
5. 将需要复制的图片或视频文件拖曳至文件列表框中。
6. 启动本程序。如果本程序已经启动，请按右上角的刷新按钮导入新文件。

- 在第一次导入时，会弹出相册权限提示，请选择 `允许所有` 以便写入新的文件。本程序不包含相册读取代码。

更多连接说明请参阅苹果官方文档：
<https://support.apple.com/zh-cn/guide/itunes/itns32636/windows>

### macOS

0. 下载和安装本软件。
1. 将设备通过 USB 连接到计算机。
2. 打开 `Finder` 。
3. 在 `Finder` 左侧栏中选择你的设备，进入你的设备信息页面。
4. 单击上方的 `文件` ，选择 `iUImport` 。
5. 将需要复制的图片或视频文件拖曳至 `iUImport` 项。
6. 启动本程序。如果本程序已经启动，请按右上角的刷新按钮导入新文件。
7. 程序会自动将刚刚导入的文件复制到相册中。

- 在第一次导入时，会弹出相册权限提示，请选择 `允许所有` 以便写入新的文件。本程序不包含相册读取代码。

更多连接说明请参阅苹果官方文档：
<https://support.apple.com/zh-cn/guide/mac-help/mchl4bd77d3a/mac>

## 隐私

本程序不会有以下任何行为之一：

- 互联网或局域网通信（如果弹出联网提示可以直接选 `不允许`）
- 收集或发送你的照片或视频到第三方
- 收取费用
- 展示广告
- 读取相册内容（因为本程序的功能只是写入）

## LICENSE

Copyright (c) 2024 KagurazakaYashi iUImport is licensed under Mulan PSL v2. You can use this software according to the terms and conditions of the Mulan PSL v2. You may obtain a copy of Mulan PSL v2 at: http://license.coscl.org.cn/MulanPSL2 THIS SOFTWARE IS PROVIDED ON AN “AS IS” BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE. See the Mulan PSL v2 for more details.
