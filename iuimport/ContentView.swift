//
//  ContentView.swift
//  iuimport
//
//  Created by 神楽坂雅詩 on 2024/3/2.
//

import Photos
import SwiftUI

// ContentView 結構體，繼承自 View 協議，用於展示和管理檔案資訊
struct ContentView: View {
    // 檔案管理器例項
    let mgr: DocumentsManager = DocumentsManager()
    // 照片庫管理器例項
    let photoLibraryMgr: PhotoLibraryManager = PhotoLibraryManager()
    // 共享的照片庫例項
    let photoLibrary: PHPhotoLibrary = PHPhotoLibrary.shared()

    // 狀態變數，儲存檔案資訊陣列
    @State var files: [FileInfoModel] = [FileInfoModel]()
    // 狀態變數，儲存圖片路徑陣列
    @State var imagePaths: [String] = [String]()
    // 狀態變數，儲存儲存狀態陣列
    @State var savedStatus: [Int8] = []
    // 狀態變數，儲存儲存狀態文字陣列
    @State var savedStatusStr: [String] = []
    // 狀態變數，儲存警報資訊陣列
    @State var alertInfo: [String] = []
    // 狀態變數，控制警報是否顯示
    @State var alertVisibled: Bool = false
    // 狀態變數，控制是否正在工作
    @State var working: Bool = false

    // 檢視主體
    var body: some View {
        NavigationView {
            // 檔案列表，使用 List 元件展示
            List($files, id: \.path) { $file in
                HStack {
                    let nowFile: FileInfoModel = $file.wrappedValue
                    let extName: String = mgr.getExtension(fromPath: nowFile.path)  // 獲取副檔名
                    let iconName: String = mgr.getIconName(extName: extName)  // 獲取圖示名稱

                    // 根據檔案型別顯示不同的圖示或縮圖
                    if iconName == "photo" {
                        if let image = UIImage(named: file.path) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        } else {
                            Image(systemName: iconName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        }
                    } else if iconName == "video" {
                        if let image = mgr.videoThumbnail(from: nowFile.path) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        } else {
                            Image(systemName: iconName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 50)
                        }
                    } else {
                        Image(systemName: iconName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    }

                    VStack(alignment: .leading) {  // 檔案資訊展示
                        Text(file.name).font(.title2)  // 檔名稱
                        Text(mgr.formatFileSize(size: file.size) + " | " + mgr.dateToString(date: file.modification)).font(.caption)  // 檔案大小和修改日期

                        HStack {
                            let index = mgr.indexFileInfoModel(fileInfos: files, path: nowFile.path)
                            if savedStatus[index] == 1 {
                                Image(systemName: "checkmark")  // 已儲存狀態
                            } else if savedStatus[index] == -1 {
                                Image(systemName: "exclamationmark.circle")  // 儲存失敗狀態
                            } else {
                                ProgressView()  // 儲存中狀態
                            }
                            Text(savedStatusStr[index]).font(.caption)  // 儲存狀態文字
                        }
                    }
                }
            }
            .toolbar {  // 工具欄
                Button(action: {
                    UIApplication.shared.open(URL(string: "https://github.com/kagurazakayashi/iuimport/blob/main/README.md")!)
                }) {
                    Image(systemName: "questionmark.circle")  // 幫助按鈕
                }
                if working {
                    ProgressView()  // 顯示工作進度條
                } else {
                    Button(action: {
                        photoLibraryMgr.saveToPhotoLibrary(view: self)
                    }) {
                        Image(systemName: "arrow.triangle.2.circlepath")  // 儲存到相簿按鈕
                    }
                }
            }
            .navigationTitle("Save into the album")  // 導航欄標題
            .alert(isPresented: $alertVisibled) {  // 警示框
                Alert(
                    title: Text(alertInfo[0]),
                    message: Text(alertInfo[1]),
                    dismissButton: .default(Text("OK"), action: {
                        self.alertVisibled = false
                    })
                )
            }
        }
        .onAppear {
            photoLibraryMgr.saveToPhotoLibrary(view: self)  // 進入檢視時自動儲存到相簿
        }
    }
}

// 預覽模式
#Preview {
    ContentView()
}
