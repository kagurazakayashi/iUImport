# iUImport

![アイコン](icon.png)

[简体中文](README.md) | [繁體中文](README.zh-hant.md) | [English](README.en.md) | [日本語](README.ja.md)

**データケーブル経由で写真やビデオを iOS フォトアルバムに簡単にインポートします。**

インターネットや LAN に接続しておらず、データケーブルのみでパソコンに接続している場合、指定した写真や動画を iOS デバイスのフォトアルバムに転送するのは面倒な作業です。 このツールを使用すると、これを簡単に行うことができます。

## システム要求

- `iOS` ≥ 15.0
- Language: `zh-hans`、`zh-hant`、`ja`、`en`

### コンパイル要件

- `Xcode` ≥ 15.0 (`SwiftUI`)
- `iOS SDK` ≥ 17

## ダウンロード

現在作者は Apple 開発者アカウントを持っていないため、まだ App Store にはアップロードされていません。 現在、Xcode を使用してのみコンパイルおよびインストールできます。

## 使用説明書

### ウィンドウズ

0. このソフトウェアをダウンロードしてインストールします。
1. USB 経由でデバイスをコンピュータに接続します。
2. 「iTunes」を開きます。
3. 「iTunes」の上にある電話アイコン ボタンをクリックすると、デバイス情報ページが表示されます。
4. 左側の「ファイル共有」をクリックし、「iUImport」を選択します。
5. コピーする画像またはビデオ ファイルをファイル リスト ボックスにドラッグします。
6. このプログラムを起動します。 プログラムがすでに開始されている場合は、右上隅にある更新ボタンを押して新しいファイルをインポートします。

- 初めてインポートする場合、アルバムの許可を求めるプロンプトが表示されます。新しいファイルの書き込みを「すべて許可」を選択してください。 このプログラムにはフォトアルバムの読み取りコードは含まれていません。

接続手順の詳細については、Apple の公式ドキュメントを参照してください。
<https://support.apple.com/zh-cn/guide/itunes/itns32636/windows>

### マックOS

0. このソフトウェアをダウンロードしてインストールします。
1. USB 経由でデバイスをコンピュータに接続します。
2. 「ファインダー」を開きます。
3. 「Finder」の左側の列でデバイスを選択し、デバイス情報ページに入ります。
4. 上の「ファイル」をクリックし、「iUImport」を選択します。
5. コピーしたい画像またはビデオファイルを「iUImport」項目にドラッグします。
6. このプログラムを起動します。 プログラムがすでに開始されている場合は、右上隅にある更新ボタンを押して新しいファイルをインポートします。
7. プログラムは、インポートしたばかりのファイルをアルバムに自動的にコピーします。

- 初めてインポートする場合、アルバムの許可を求めるプロンプトが表示されます。新しいファイルの書き込みを「すべて許可」を選択してください。 このプログラムにはフォトアルバムの読み取りコードは含まれていません。

接続手順の詳細については、Apple の公式ドキュメントを参照してください。
<https://support.apple.com/zh-cn/guide/mac-help/mchl4bd77d3a/mac>

## プライバシー

このプログラムは次のことを行いません。

- インターネットまたは LAN 通信 (ネットワーク プロンプトが表示された場合は、「許可しない」を直接選択できます)
- 写真やビデオを収集したり、第三者に送信したりする
- 手数料
- ディスプレイ広告
- アルバムの内容を読む（このプログラムの機能は書き込みのみなので）

## LICENSE

Copyright (c) 2024 KagurazakaYashi iUImport is licensed under Mulan PSL v2. You can use this software according to the terms and conditions of the Mulan PSL v2. You may obtain a copy of Mulan PSL v2 at: http://license.coscl.org.cn/MulanPSL2 THIS SOFTWARE IS PROVIDED ON AN “AS IS” BASIS, WITHOUT WARRANTIES OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO NON-INFRINGEMENT, MERCHANTABILITY OR FIT FOR A PARTICULAR PURPOSE. See the Mulan PSL v2 for more details.
