//
//  iuimportApp.swift
//  iuimport
//
//  Created by 神楽坂雅詩 on 2024/3/2.
//

// 匯入 SwiftUI 框架，用於構建使用者介面
import SwiftUI

// 主應用程式結構，使用 @main 屬性標記為應用程式的入口點
@main
struct iuimportApp: App {
    // 主檢視體，定義了應用程式的主要場景
    var body: some Scene {
        // 建立視窗組，用於管理應用程式的視窗
        WindowGroup {
            // 顯示內容檢視，即應用程式的主介面
            ContentView()
        }
    }
}
