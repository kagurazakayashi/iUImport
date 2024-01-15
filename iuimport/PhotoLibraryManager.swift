//
//  PhotoLibraryManager.swift
//  iuimport
//
//  Created by 神楽坂雅詩 on 2024/3/2.
//

import Foundation
import Photos

protocol PhotoLibraryManagerDelegate {
    func saveOK(isVideo:Bool, path:String)
    func saveFail(isVideo:Bool, path:String, error:String)
}

class PhotoLibraryManager {
    var delegate: PhotoLibraryManagerDelegate?
    let photoLibrary: PHPhotoLibrary = PHPhotoLibrary.shared()
    
    var isPhotoLibraryReadWriteAccessGranted: Bool {
        get async {
            let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
            
            // Determine if the user previously authorized read/write access.
            var isAuthorized = status == .authorized
            
            // If the system hasn't determined the user's authorization status,
            // explicitly prompt them for approval.
            if status == .notDetermined {
                isAuthorized = await PHPhotoLibrary.requestAuthorization(for: .readWrite) == .authorized
            }
            
            return isAuthorized
        }
    }
        
    func saveToPhotoLibrary(view:ContentView) -> Void {
        view.files = view.mgr.getDocumentsFiles()
        view.savedStatus = Array(repeating: 0, count: view.files.count)
        view.savedStatusStr = Array(repeating: "正在保存到相册", count: view.files.count)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            for file in view.files {
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
            }
        }
    }
}
