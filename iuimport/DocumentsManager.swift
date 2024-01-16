//
//  DocumentsManager.swift
//  iuimport
//
//  Created by 神楽坂雅詩 on 2024/3/2.
//

import Foundation
import SwiftUI
import AVFoundation

class FileInfoModel: Identifiable {
    var name: String = ""
    var path: String = ""
    var size: Int = 0
    var creation: Date = Date()
    var modification: Date = Date()
    var status: Int8 = 0
}

class DocumentsManager {
    let fileManager = FileManager.default
    
    func getDocumentsFiles() -> [FileInfoModel] {
        guard let documentDirectoryURL:URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return [] }
        let documentPath:String = documentDirectoryURL.path
        guard let documentURL:URL = URL(string: documentPath) else { return [] }
        var allFiles:[FileInfoModel] = []
        do {
            let files:[String] = try fileManager.contentsOfDirectory(atPath: documentPath)
            for file in files {
                let model:FileInfoModel = FileInfoModel()
                model.name = file
                let fullURL:URL = documentURL.appendingPathComponent(file)
                model.path = fullURL.path
                let attributes:[FileAttributeKey : Any] = try fileManager.attributesOfItem(atPath: model.path)
                model.size = attributes[.size] as! Int
                model.creation = attributes[.creationDate] as! Date
                model.modification = attributes[.modificationDate] as! Date
//                print(model.name,model.path,model.size,model.creation,model.modification)
                allFiles.append(model)
            }
        } catch {
            print("Error getting contents of directory: \(error)")
            return []
        }
        return allFiles
    }
    
    func formatFileSize(size: Int, base: Double = 1024.0) -> String {
        let units:[String] = ["", "K", "M", "G", "T", "P", "E"]
        var fileSize:Double = Double(size)
        var index:Int = 0
        while fileSize >= base && index < units.count - 1 {
            fileSize /= base
            index += 1
        }
        return String(format: "%.2f %@B", fileSize, units[index])
    }
    
    func dateToString(date: Date, style:DateFormatter.Style = DateFormatter.Style.full, locale:Locale = Locale.current) -> String {
        let dateFormatter:DateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: date)
    }
    
    func getExtension(fromPath path: String) -> String {
        let fileName = URL(fileURLWithPath: path).lastPathComponent
        let components = fileName.components(separatedBy: ".")
        guard components.count > 1 else {
            return ""
        }
        return components.last ?? ""
    }
    
    func getIconName(extName: String) -> String {
        var iconName = "doc"
        switch extName {
        case "heif", "jpg", "jpeg", "raw", "png", "gif", "tiff", "jfif":
            // https://support.apple.com/en-us/108314
            iconName = "photo"
            break;
        case "hevc", "mp4", "mov":
            iconName = "video"
            break;
        default:
            break;
        }
        return iconName
    }
    
    func videoThumbnail(from path: String) -> UIImage? {
        let videoURL = URL(fileURLWithPath: path)
        let asset = AVAsset(url: videoURL)
        let imageGenerator = AVAssetImageGenerator(asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true
        let time = CMTime(seconds: 0, preferredTimescale: 600)
        var actualTime: CMTime = CMTime()
        guard let imageRef = try? imageGenerator.copyCGImage(at: time, actualTime: &actualTime) else {
            return nil
        }
//        let image = UIImage(cgImage: imageRef)
        return UIImage(cgImage: imageRef)
    }
    
    func indexFileInfoModel(fileInfos:[FileInfoModel], path:String) -> Int {
        var i = 0;
        for fileInfo in fileInfos {
            if (fileInfo.path == path) {
                return i
            }
            i = i + 1
        }
        return -1;
    }

}
