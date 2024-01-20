//
//  ContentView.swift
//  iuimport
//
//  Created by 神楽坂雅詩 on 2024/3/2.
//

import Photos
// 匯入 SwiftUI 框架
import SwiftUI

// 結構體 ContentView 繼承自 View 協定
struct ContentView: View {
  // 文件管理器
  let mgr: DocumentsManager = DocumentsManager()
  // 照片庫管理器
  let photoLibraryMgr: PhotoLibraryManager = PhotoLibraryManager()
  // 共享的照片庫
  let photoLibrary: PHPhotoLibrary = PHPhotoLibrary.shared()

  // 狀態變量，儲存文件信息
  @State var files: [FileInfoModel] = [FileInfoModel]()
  // 狀態變量，儲存圖片路徑
  @State var imagePaths: [String] = [String]()
  // 狀態變量，儲存儲存狀態
  @State var savedStatus: [Int8] = []
  // 狀態變量，儲存儲存狀態文字
  @State var savedStatusStr: [String] = []
  // 狀態變量，儲存警報信息
  @State var alertInfo: [String] = []
  // 狀態變量，控制警報是否顯示
  @State var alertVisibled: Bool = false
  // 狀態變量，控制是否正在工作
  @State var working: Bool = false

  // 畫面主體
  var body: some View {
    NavigationView {
      List($files, id: \.path) { $file in  // 檔案列表
        HStack {
          let nowFile: FileInfoModel = $file.wrappedValue
          let extName: String = mgr.getExtension(fromPath: nowFile.path)  // 取得副檔名
          let iconName: String = mgr.getIconName(extName: extName)  // 取得圖示名稱

          if iconName == "photo" {  // 檢查是否為照片
            if let image = UIImage(named: file.path) {
              Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)  // 顯示縮圖
            } else {  // 無法讀取為照片時，顯示預設圖示
              Image(systemName: iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            }
          } else if iconName == "video" {  // 檢查是否為影片
            if let image = mgr.videoThumbnail(from: nowFile.path) {  // 嘗試生成影片縮圖
              Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            } else {  // 無法取得縮圖時，顯示預設圖示
              Image(systemName: iconName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
            }
          } else {  // 其他類型的檔案
            Image(systemName: iconName)
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 50, height: 50)
          }

          VStack(alignment: .leading) {  // 檔案資訊
            Text(file.name).font(.title2)  // 檔案名稱
            Text(
              mgr.formatFileSize(size: file.size) + " | "
                + mgr.dateToString(date: file.modification)
            ).font(.caption)  // 檔案大小與修改日期

            HStack {
              let index = mgr.indexFileInfoModel(fileInfos: files, path: nowFile.path)
              if savedStatus[index] == 1 {  // 顯示儲存狀態
                Image(systemName: "checkmark")
              } else if savedStatus[index] == -1 {
                Image(systemName: "exclamationmark.circle")
              } else {
                ProgressView()  // 顯示進度條
              }
              Text(savedStatusStr[index]).font(.caption)
            }
          }
        }
      }
      .toolbar {  // 工具列
        Button(action: {
          UIApplication.shared.open(URL(string: "https://github.com/kagurazakayashi/iuimport/blob/main/README.md")!)
        }) {
          Image(systemName: "questionmark.circle")  // 儲存到相簿按鈕
        }
        if working {
          ProgressView()  // 顯示工作進行中的進度條
        } else {
          Button(action: {
            photoLibraryMgr.saveToPhotoLibrary(view: self)
          }) {
            Image(systemName: "arrow.triangle.2.circlepath")  // 儲存到相簿按鈕
          }
        }
      }
      .navigationTitle("Save into the album")  // 導航列標題
      .alert(isPresented: $alertVisibled) {  // 警示框
        Alert(
          title: Text(alertInfo[0]),
          message: Text(alertInfo[1]),
          dismissButton: .default(
            Text("OK"),
            action: {
              self.alertVisibled = false
            })
        )
      }
    }
    .onAppear {
      photoLibraryMgr.saveToPhotoLibrary(view: self)  // 進入畫面時自動儲存到相簿
    }
  }
}

// 預覽模式
#Preview {
  ContentView()
}
