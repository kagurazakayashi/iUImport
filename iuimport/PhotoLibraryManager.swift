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
    var saveIndex: Int = -1
    
    func hasPhotoWritePermission(view:ContentView) -> Bool {
        let status:PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            return true
        case .notDetermined:
            Task {
                PHPhotoLibrary.requestAuthorization(for: .readWrite) {_ in
                    _ = self.hasPhotoWritePermission(view: view);
                }
            }
            return false
//        case .denied, .restricted, .limited:
        default:
            view.alertInfo = [String(localized: "No album write permission!"), String(localized: "You must allow album access to write new media.")]
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
        let permission = hasPhotoWritePermission(view: view)
        if (fileCount == 0) {
            view.alertInfo = [String(localized: "No file"), String(localized: "There are no photos or videos in the cache, please connect to iTunes to import them into the documents of this APP.")]
            view.alertVisibled = true
        }
        if (permission == false) {
            if (fileCount > 0) {
                view.savedStatus = Array(repeating: -1, count: fileCount)
                view.savedStatusStr = Array(repeating: String(localized: "No album write permission!"), count: fileCount)
                view.files = files
            }
        }
        if (fileCount == 0 || permission == false) {
            return
        }
        view.savedStatus = Array(repeating: 0, count: fileCount)
        view.savedStatusStr = Array(repeating: String(localized: "Saving to album ..."), count: fileCount)
        view.files = files
        view.working = true
        saveIndex = 0
        saveOnce(view: view)
    }
    
    func saveOnce(view:ContentView) {
        let file: FileInfoModel = view.files[saveIndex]
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
                        view.savedStatusStr[index] = String(localized: "Saved successfully.")
                        if (self.deleteFile(atPath: file.path) == false) {
                            view.savedStatus[index] = -1
                            view.savedStatusStr[index] = "Failed to delete cache files!"
                        }
                    } else {
                        view.savedStatus[index] = -1
                        view.savedStatusStr[index] = String(localized: "Save failed!") + " " + (error?.localizedDescription ?? "")
                        print(view.savedStatusStr[index])
                    }
                })
        } else {
            view.savedStatus[index] = -1
            view.savedStatusStr[index] = String(localized: "Unsupported file format!")
        }
        saveIndex = saveIndex + 1
        if (saveIndex == view.files.count) {
            view.working = false
        } else {
            saveOnce(view: view)
        }
    }
}
