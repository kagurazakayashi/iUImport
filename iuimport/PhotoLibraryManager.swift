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
    let photoLibrary: PHPhotoLibrary = PHPhotoLibrary.shared()
    
    func hasPhotoWritePermission(view:ContentView) -> Bool {
        let status:PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            return true
        case .notDetermined:
            Task {
                await PHPhotoLibrary.requestAuthorization(for: .readWrite)
            }
            return false
//        case .denied, .restricted, .limited:
        default:
            view.alertInfo = ["没有相册写入权限", "您必须允许相册访问权限，才能写入新的媒体。"]
            view.alertVisibled = true
            return false
        }
    }
    
    func deleteFile(atPath path: String) -> Bool {
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: path) {
            return false
        }
        do {
            try fileManager.removeItem(atPath: path)
            return true
        } catch {
            return false
        }
    }

    func saveToPhotoLibrary(view:ContentView) -> Void {
        view.savedStatus = []
        view.savedStatusStr = []
        view.files = []
        let files:[FileInfoModel] = view.mgr.getDocumentsFiles()
        let fileCount:Int = files.count
        if hasPhotoWritePermission(view: view) == false {
            if (fileCount > 0) {
                view.savedStatus = Array(repeating: -1, count: fileCount)
                view.savedStatusStr = Array(repeating: "没有相册写入权限", count: fileCount)
                view.files = files
            }
            return
        }
        if (fileCount == 0) {
            view.alertInfo = ["没有文件", "缓存区中没有照片或视频，请连接 iTunes 导入至本 APP 的文档中。"]
            view.alertVisibled = true
            return
        }
        view.savedStatus = Array(repeating: 0, count: fileCount)
        view.savedStatusStr = Array(repeating: "正在保存到相册", count: fileCount)
        view.files = files
        view.working = true
        var i = 0
        for file in view.files {
            i = i + 1
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(i)) {
                let index = view.mgr.indexFileInfoModel(fileInfos: view.files, path: file.path)
                let extName:String = view.mgr.getExtension(fromPath: file.path)
                let iconName:String = view.mgr.getIconName(extName: extName)
                let url:URL = URL(fileURLWithPath: file.path)
                if (iconName == "photo" || iconName == "video") {
                    let isVideo:Bool = (iconName == "video")
                    view.photoLibrary.performChanges(
                        isVideo
                        ? {PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)}
                        : {PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: url)}
                        , completionHandler: { success, error in
                            if (success) {
                                view.savedStatus[index] = 1
                                view.savedStatusStr[index] = "保存成功"
                            } else {
                                view.savedStatus[index] = -1
                                view.savedStatusStr[index] = "保存失败 " + (error?.localizedDescription ?? "")
                            }
                        })
                } else {
                    view.savedStatus[index] = -1
                    view.savedStatusStr[index] = "不支持的文件格式"
                }
                if (self.deleteFile(atPath: file.path) == false) {
                    view.savedStatus[index] = -1
                    view.savedStatusStr[index] = "删除缓存文件失败"
                }
            }
            if (i == fileCount) {
                view.working = false
            }
        }
    }
}
