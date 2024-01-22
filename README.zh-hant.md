# iUImport

![Icon](icon.png)

[简体中文](README.md) | [繁體中文](README.zh-hant.md) | [English](README.en.md) | [日本語](README.ja.md)

**透過資料線將照片或影片輕鬆匯入到 iOS 相簿中。**
如果沒有網際網路和區域網連線、只有資料線連線電腦時，向 iOS 裝置的相簿中傳輸指定的照片或影片是一件麻煩的事情。這個工具可以讓你更輕鬆的完成這項事務。

## 系統要求

- `iOS` ≥ 15.0
- Language: `zh-hans`, `zh-hant`, `ja`, `en`

### 編譯要求

- `Xcode` ≥ 15.0 (`SwiftUI`)
- `iOS SDK` ≥ 17

## 下載

由於作者目前沒有蘋果開發者賬戶，暫時沒有上傳到應用商店。目前只能夠使用 Xcode 編譯安裝。

## 使用說明

### Windows

0. 下載和安裝本軟體。
1. 將裝置透過 USB 連線到計算機。
2. 開啟 `iTunes` 。
3. 單擊 `iTunes` 上方的手機圖示按鈕，將能看到你的裝置資訊頁面。
4. 單擊左側的 `檔案共享` ，選擇 `iUImport` 。
5. 將需要複製的圖片或影片檔案拖曳至檔案列表框中。
6. 啟動本程式。如果本程式已經啟動，請按右上角的重新整理按鈕匯入新檔案。

- 在第一次匯入時，會彈出相簿許可權提示，請選擇 `允許所有` 以便寫入新的檔案。本程式不包含相簿讀取程式碼。
更多連線說明請參閱蘋果官方文件： <https://support.apple.com/zh-cn/guide/itunes/itns32636/windows>

### macOS

0. 下載和安裝本軟體。
1. 將裝置透過 USB 連線到計算機。
2. 開啟 `Finder` 。
3. 在 `Finder` 左側欄中選擇你的裝置，進入你的裝置資訊頁面。
4. 單擊上方的 `檔案` ，選擇 `iUImport` 。
5. 將需要複製的圖片或影片檔案拖曳至 `iUImport` 項。
6. 啟動本程式。如果本程式已經啟動，請按右上角的重新整理按鈕匯入新檔案。 7. 程式會自動將剛剛匯入的檔案複製到相簿中。

- 在第一次匯入時，會彈出相簿許可權提示，請選擇 `允許所有` 以便寫入新的檔案。本程式不包含相簿讀取程式碼。
更多連線說明請參閱蘋果官方文件： <https://support.apple.com/zh-cn/guide/mac-help/mchl4bd77d3a/mac>

## 隱私

本程式不會有以下任何行為之一：

- 網際網路或區域網通訊（如果彈出聯網提示可以直接選 `不允許`）
- 收集或傳送你的照片或影片到第三方
- 收取費用
- 展示廣告
- 讀取相簿內容（因為本程式的功能只是寫入）

## LICENSE

Copyright (c) 2024 KagurazakaYashi iUImport is licensed under Mulan PSL v2. You can use this software according to the terms and conditions of the Mulan PSL v2. You may obtain a copy of Mulan PSL v2 at: http://license.coscl.org.cn/MulanPSL2 THIS SOFTWARE IS PROVIDED ON AN “AS IS” BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE. See the Mulan PSL v2 for more details.
