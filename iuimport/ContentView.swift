//
//  ContentView.swift
//  iuimport
//
//  Created by 神楽坂雅詩 on 2024/3/2.
//

// 匯入 SwiftUI 框架
import SwiftUI

// 結構體 ContentView 繼承自 View 協定
struct ContentView: View {
    let mgr = DocumentsManager()
    @State var files:[FileInfoModel] = [FileInfoModel]()
    var body: some View {
        NavigationView {
            List(files) { file in
                HStack {
                    let extName:String = mgr.getExtension(fromPath: file.path)
                    let iconName:String = mgr.getIconName(extName: extName)
                    if (iconName == "photo") {
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
                    } else if (iconName == "video") {
                        if let image = mgr.videoThumbnail(from: file.path) {
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
                    VStack(alignment: .leading) {
                        Text(file.name).font(.title2)
                        Text(mgr.formatFileSize(size: file.size)+" | "+mgr.dateToString(date: file.modification)).font(.caption)
                    }
                    Spacer()
//                    Image(systemName: "checkmark")
                    ProgressView()
                }
            }
            .toolbar {
                Button(action: {
                    // TODO: 选择文件
                }) {
                    Text("选择文件")
                }
            }
        }
        .onAppear {
            // 加载文档
            files = mgr.getDocumentsFiles()
        }
    }
}

// 預覽
#Preview {
    // 顯示 ContentView 視圖
    ContentView()
}
