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
    let photoLibrary: PHPhotoLibrary = PHPhotoLibrary.shared()  // 取得照片圖庫的實例
    var saveIndex: Int = -1  // 儲存照片索引值

    func hasPhotoWritePermission(view: ContentView) -> Bool {  // 檢查是否擁有照片寫入權限
        let status: PHAuthorizationStatus =
            PHPhotoLibrary.authorizationStatus()  // 取得授權狀態
        switch status {
        case .authorized:
            return true  // 已授權
        case .notDetermined:
            Task {  // 請求授權的異步任務
                PHPhotoLibrary.requestAuthorization(for: .readWrite) { _ in
                    _ = self.hasPhotoWritePermission(view: view)
                }
            }
            return false  // 尚未授權
        default:  // 其它狀態 (包含 .denied, .restricted, .limited)
            view.alertInfo = [  // 設定警告訊息
                String(localized: "No album write permission!"),
                String(
                    localized: "You must allow album access to write new media."
                ),
            ]
            view.alertVisibled = true  // 顯示警告視窗
            return false
        }
    }

    func deleteFile(atPath path: String) -> Bool {  // 刪除檔案
        let fileManager: FileManager = FileManager.default  // 取得檔案管理員實例
        if !fileManager.fileExists(atPath: path) {  // 檢查檔案是否存在
            return false
        }
        do {
            try fileManager.removeItem(atPath: path)  // 刪除檔案
            return true
        } catch {
            return false  // 刪除失敗
        }
    }

    func saveToPhotoLibrary(view: ContentView) {
        view.savedStatus = []  // 清空儲存狀態陣列
        view.savedStatusStr = []  // 清空儲存狀態訊息陣列
        view.files = []  // 清空檔案列表

        let files: [FileInfoModel] = view.mgr.getDocumentsFiles()  // 取得 App 文件資料夾中的檔案
        let fileCount: Int = files.count  // 檔案數量
        let permission = hasPhotoWritePermission(view: view)  // 檢查相簿寫入權限

        if fileCount == 0 {
            view.alertInfo = [
                String(localized: "No file"),  // 找不到檔案時的標題
                String(
                    localized:
                        "There are no photos or videos in the cache, please connect to iTunes to import them into the documents of this APP."
                ),  // 找不到檔案時的提示訊息
            ]
            view.alertVisibled = true  // 顯示提示框
        }
        if permission == false {  // 沒有權限的情況
            if fileCount > 0 {
                view.savedStatus = Array(repeating: -1, count: fileCount)  // 初始化儲存狀態為失敗 (-1)
                view.savedStatusStr = Array(
                    repeating: String(localized: "No album write permission!"),
                    count: fileCount)
                view.files = files
            }
        }

        if fileCount == 0 || permission == false {
            return  // 沒有檔案或沒有權限時，直接結束函式
        }

        view.savedStatus = Array(repeating: 0, count: fileCount)  // 初始化儲存狀態為「儲存中」(0)
        view.savedStatusStr = Array(
            repeating: String(localized: "Saving to album ..."),
            count: fileCount)
        view.files = files
        view.working = true  // 標記為運作中

        saveIndex = 0
        saveOnce(view: view)
    }

    func saveOnce(view: ContentView) {
        if saveIndex < 0 || view.files.count == 0 {
            return  // 索引異常或沒有檔案時結束
        }

        let file: FileInfoModel = view.files[saveIndex]  // 取得當前要儲存的檔案
        let index = view.mgr.indexFileInfoModel(
            fileInfos: view.files, path: file.path)
        let extName: String = view.mgr.getExtension(fromPath: file.path)  // 取得副檔名
        let iconName: String = view.mgr.getIconName(extName: extName)  // 取得圖示名稱
        let url: URL = URL(fileURLWithPath: file.path)

        if iconName == "photo" || iconName == "video" {
            let isVideo: Bool = (iconName == "video")  // 判斷是否為影片
            view.photoLibrary.performChanges(
                isVideo
                    ? {
                        PHAssetChangeRequest.creationRequestForAssetFromVideo(
                            atFileURL: url)
                    }  // 儲存影片
                    : {
                        PHAssetChangeRequest.creationRequestForAssetFromImage(
                            atFileURL: url)
                    },  // 儲存圖片
                completionHandler: { success, error in
                    if success {
                        view.savedStatus[index] = 1  // 儲存成功標記
                        view.savedStatusStr[index] = String(
                            localized: "Saved successfully.")
                        if self.deleteFile(atPath: file.path) == false {  // 嘗試刪除快取檔案
                            view.savedStatus[index] = -1
                            view.savedStatusStr[index] =
                                "Failed to delete cache files!"
                        }
                    } else {
                        view.savedStatus[index] = -1  // 儲存失敗標記
                        view.savedStatusStr[index] =
                            String(localized: "Save failed!") + " "
                            + (error?.localizedDescription ?? "")
                        print(view.savedStatusStr[index])
                    }
                })
        } else {
            view.savedStatus[index] = -1
            view.savedStatusStr[index] = String(
                localized: "Unsupported file format!")
        }

        saveIndex = saveIndex + 1
        if saveIndex >= view.files.count {
            view.working = false  // 完成儲存流程
        } else {
            saveOnce(view: view)  // 儲存下一個檔案
        }
    }
}
