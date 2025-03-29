# 影線

![Icon](icon.png)

[简体中文](README.md) | [繁體中文](README.zh-hant.md) | [English](README.en.md) | [日本語](README.ja.md)

**ケーブル経由でiOSアルバムに写真やビデオを簡単にインポート。**

インターネットやLAN 接続がなく、PCに接続するデータケーブルしかない場合、写真やビデオをデバイスのアルバムに転送するのは面倒かもしれません。このツールを使えば、この作業をより簡単に行うことができます。

## システム要件

- `iOS` ≥ 15.0
- 言語: `zh-hans`, `zh-hant`, `ja`, `ja`

### コンパイルの要件

- `Xcode` ≥ 15.0 (`SwiftUI`)
- `iOS SDK ≥ 17`

## ダウンロード

作者は現在Appleの開発者アカウントを持っていないため、現時点ではApp Storeにアップロードされていない。現在のところ、Xcodeを使ってコンパイルし、インストールすることしかできない。

## 使用方法

### ウィンドウズ

1. このソフトウェアをダウンロードしてインストールする。
2. USB経由でデバイスをコンピュータに接続する。
3. `iTunesを開きます。`
4. `iTunes`の上にある携帯電話のアイコンボタンをクリックすると、デバイス情報のページに移動します。
5. 左側の`File Sharing`をクリックし、`iUImport を選択します。`
6. コピーしたい画像や動画ファイルをファイルリストボックスにドラッグ＆ドロップします。
7. このプログラムを開始します。この番組がすでに始まっている場合は、右上の更新ボタンを押して新しいファイルをインポートしてください。

- 初めてインポートする場合、アルバム許可のプロンプトがポップアップ表示されますので、新しいファイルを書き込むために`Allow All`を選択してください。このアプリケーションには、アルバム読み取りコードは含まれていません。

詳しい接続方法については、Appleの公式ドキュメントを参照してください： [https://support.apple.com/zh-cn/guide/itunes/itns32636/windows](https://support.apple.com/zh-cn/guide/itunes/itns32636/windows)

### マックオス

1. このソフトウェアをダウンロードしてインストールする。
2. USB経由でデバイスをコンピュータに接続する。
3. `ファインダーを開く。`
4. `ファインダー`の左サイドバーでデバイスを選択すると、デバイス情報ページに移動します。
5. 上の`File`をクリックし、`iUImport`を選択します。
6. コピーしたい画像または動画ファイルを`iUImport` アイテムにドラッグ＆ドロップします。
7. このプログラムを開始します。この番組がすでに始まっている場合は、右上の更新ボタンを押して新しいファイルをインポートしてください。
8. プログラムは、インポートしたファイルを自動的にアルバムにコピーします。

- 初めてインポートする場合、アルバム許可のプロンプトがポップアップ表示されますので、新しいファイルを書き込むために`Allow All`を選択してください。このアプリケーションには、アルバム読み取りコードは含まれていません。

詳しい接続方法については、Appleの公式ドキュメントを参照してください： [https://support.apple.com/zh-cn/guide/mac-help/mchl4bd77d3a/mac](https://support.apple.com/zh-cn/guide/mac-help/mchl4bd77d3a/mac)

## みんかんきぎょう

このプログラムでは、以下のことは一切行わない：

- インターネットまたはLAN通信（ネットワークのポップアッププロンプトが表示された場合は、`Don't Allow`を選択するだけです。）
- お客様の写真やビデオを収集したり、第三者に送信したりすること。
- 料金
- ディスプレイ広告
- アルバムの内容を読み込む（このプログラムの機能は書き込みだけなので）

## LICENSE

Copyright (c) 2024 KagurazakaYashi iUImport is licensed under Mulan PSL v2. You can use this software according to the terms and conditions of the Mulan PSL v2. You may obtain a copy of Mulan PSL v2 at: http://license.coscl.org.cn/MulanPSL2 THIS SOFTWARE IS PROVIDED ON AN “AS IS” BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE. See the Mulan PSL v2 for more details.
