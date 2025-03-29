//
//  PhotoLibraryManager.swift
//  iuimport
//
//  Created by 神楽坂雅詩 on 2024/3/2.
//

import Foundation
import Photos
import UIKit

class PhotoLibraryManager {
    // 獲取照片庫的共享例項
    let photoLibrary: PHPhotoLibrary = PHPhotoLibrary.shared()
    // 儲存照片時的索引值
    var saveIndex: Int = -1

    /// 檢查是否擁有照片寫入許可權
    /// - Parameters:
    ///   - view: `ContentView` 例項，用於顯示警告資訊
    /// - Returns: 布林值，表示是否擁有寫入許可權
    func hasPhotoWritePermission(view: ContentView) -> Bool {
        let status: PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            return true  // 已授權
        case .notDetermined:
            Task {
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { _ in
                    _ = self.hasPhotoWritePermission(view: view)
                }
            }
            return false  // 尚未授權
        default:
            // 設定警告資訊並顯示警告視窗
            view.alertInfo = [
                String(localized: "No album write permission!"),
                String(localized: "You must allow album access to write new media.")
            ]
            view.alertVisibled = true
            return false
        }
    }

    /// 刪除指定路徑的檔案
    /// - Parameters:
    ///   - path: 要刪除的檔案路徑
    /// - Returns: 布林值，表示刪除是否成功
    func deleteFile(atPath path: String) -> Bool {
        let fileManager: FileManager = FileManager.default
        if !fileManager.fileExists(atPath: path) {
            return false  // 檔案不存在
        }
        do {
            try fileManager.removeItem(atPath: path)
            return true  // 刪除成功
        } catch {
            return false  // 刪除失敗
        }
    }

    /// 將檔案儲存到照片庫
    /// - Parameters:
    ///   - view: `ContentView` 例項，用於更新UI狀態
    func saveToPhotoLibrary(view: ContentView) {
        // 清空儲存狀態和檔案列表
        view.savedStatus = []
        view.savedStatusStr = []
        view.files = []

        // 獲取App資料夾中的檔案
        let files: [FileInfoModel] = view.mgr.getDocumentsFiles()
        let fileCount: Int = files.count
        let permission = hasPhotoWritePermission(view: view)

        // 沒有檔案或沒有寫入許可權時處理
        if fileCount == 0 {
            view.alertInfo = [
                String(localized: "No file"),
                String(localized: "There are no photos or videos in the cache, please connect to iTunes to import them into the documents of this APP.")
            ]
            view.alertVisibled = true
        }
        if permission == false {
            if fileCount > 0 {
                // 初始化儲存狀態為失敗
                view.savedStatus = Array(repeating: -1, count: fileCount)
                view.savedStatusStr = Array(repeating: String(localized: "No album write permission!"), count: fileCount)
                view.files = files
            }
        }

        // 沒有檔案或沒有許可權時直接返回
        if fileCount == 0 || permission == false {
            return
        }

        // 初始化儲存狀態為“儲存中”
        view.savedStatus = Array(repeating: 0, count: fileCount)
        view.savedStatusStr = Array(repeating: String(localized: "Saving to album ..."), count: fileCount)
        view.files = files
        view.working = true

        saveIndex = 0
        saveOnce(view: view)
    }

    /// 儲存單個檔案到照片庫
    /// - Parameters:
    ///   - view: `ContentView` 例項，用於更新UI狀態
    func saveOnce(view: ContentView) {
        if saveIndex < 0 || view.files.count == 0 {
            return  // 索引異常或沒有檔案時結束
        }

        let file: FileInfoModel = view.files[saveIndex]
        let index = view.mgr.indexFileInfoModel(fileInfos: view.files, path: file.path)
        let extName: String = view.mgr.getExtension(fromPath: file.path)
        let iconName: String = view.mgr.getIconName(extName: extName)
        let url: URL = URL(fileURLWithPath: file.path)

        // 僅處理圖片和影片檔案
        if iconName == "photo" || iconName == "video" {
            let isVideo: Bool = (iconName == "video")
            view.photoLibrary.performChanges(
                isVideo
                    ? {
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
                    }
                    : {
                        PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)
                    },
                completionHandler: { success, error in
                    if success {
                        // 儲存成功，更新狀態並嘗試刪除快取檔案
                        view.savedStatus[index] = 1
                        view.savedStatusStr[index] = String(localized: "Saved successfully.")
                        if self.deleteFile(atPath: file.path) == false {
                            view.savedStatus[index] = -1
                            view.savedStatusStr[index] = "Failed to delete cache files!"
                        }
                    } else {
                        // 儲存失敗，更新狀態並顯示錯誤資訊
                        view.savedStatus[index] = -1
                        view.savedStatusStr[index] = String(localized: "Save failed!") + " " + (error?.localizedDescription ?? "")
                        print(view.savedStatusStr[index])
                    }
                }
            )
        } else {
            // 不支援的檔案格式，更新狀態
            view.savedStatus[index] = -1
            view.savedStatusStr[index] = String(localized: "Unsupported file format!")
        }

        saveIndex += 1
        if saveIndex >= view.files.count {
            view.working = false  // 完成儲存流程
        } else {
            saveOnce(view: view)  // 儲存下一個檔案
        }
    }
}
