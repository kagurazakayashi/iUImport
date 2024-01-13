//
//  ContentView.swift
//  iuimport
//
//  Created by 神楽坂雅詩 on 2024/3/2.
//

// 匯入 SwiftUI 框架
import SwiftUI

class FileModel: Identifiable {
    var name: String?
    var info: String?
    init(name: String? = nil, info: String? = nil) {
        self.name = name
        self.info = info
    }
}

// 結構體 ContentView 繼承自 View 協定
struct ContentView: View {
    let mgr = DocumentsManager()
    @State var files = [FileModel]()
    var body: some View {
        NavigationView {
            List(files) { file in
                HStack {
                    Text(file.name ?? "")
                    Text(file.info ?? "")
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
            
        }
    }
}

// 預覽
#Preview {
    // 顯示 ContentView 視圖
    ContentView()
}
