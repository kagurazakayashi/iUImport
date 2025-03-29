//
//  DocumentsManager.swift
//  iuimport
//
//  Created by 神楽坂雅詩 on 2024/3/2.
//

import AVFoundation
import Foundation
import SwiftUI

class FileInfoModel: Identifiable {
    /// 檔名稱
    var name: String = ""
    /// 檔案路徑
    var path: String = ""
    /// 檔案大小（單位：位元組）
    var size: Int = 0
    /// 建立日期
    var creation: Date = Date()
    /// 修改日期
    var modification: Date = Date()
    /// 檔案狀態
    var status: Int8 = 0
}

class DocumentsManager {
    let fileManager: FileManager = FileManager.default

    /// 獲取Documents資料夾中的所有檔案資訊
    /// - Returns: 包含所有檔案資訊的陣列
    func getDocumentsFiles() -> [FileInfoModel] {
        // 檢查是否能獲取Documents資料夾的URL
        guard let documentDirectoryURL: URL = FileManager.default.urls(
            for: .documentDirectory, in: .userDomainMask
        ).first else { return [] }

        // 獲取Documents資料夾路徑
        let documentPath: String = documentDirectoryURL.path

        // 轉換路徑為URL格式
        guard let documentURL: URL = URL(string: documentPath) else {
            return []
        }

        // 宣告存放檔案資訊的陣列
        var allFiles: [FileInfoModel] = []

        // 嘗試讀取Documents資料夾下的檔案
        do {
            let files: [String] = try FileManager.default.contentsOfDirectory(
                atPath: documentPath)

            // 逐一處理每個檔案
            for file: String in files {
                let model: FileInfoModel = FileInfoModel()
                model.name = file  // 檔名稱
                let fullURL: URL = documentURL.appendingPathComponent(file)  // 組合完整檔案URL
                model.path = fullURL.path  // 完整檔案路徑

                // 獲取檔案屬性
                let attributes: [FileAttributeKey: Any] =
                    try FileManager.default.attributesOfItem(
                        atPath: model.path)
                model.size = attributes[.size] as! Int  // 檔案大小
                model.creation = attributes[.creationDate] as! Date  // 建立日期
                model.modification = attributes[.modificationDate] as! Date  // 修改日期

                allFiles.append(model)  // 將檔案資訊加入陣列
            }
        } catch {  // 若發生錯誤
            print("ERROR: \(error)")
            return []  // 返回空陣列
        }

        return allFiles  // 返回包含所有檔案資訊的陣列
    }

    /// 格式化檔案大小
    /// - Parameters:
    ///   - size: 檔案大小（位元組）
    ///   - base: 單位基數，預設為1024（KB）
    /// - Returns: 格式化後的檔案大小字串
    func formatFileSize(size: Int, base: Double = 1024.0) -> String {
        let units: [String] = ["", "K", "M", "G", "T", "P", "E"]  // 檔案大小單位
        var fileSize: Double = Double(size)  // 檔案大小（位元組）
        var index: Int = 0  // 單位索引

        // 持續迴圈，直到檔案大小小於單位基數或是已達最大單位
        while fileSize >= base && index < units.count - 1 {
            fileSize /= base  // 將檔案大小除以基數進行單位換算
            index += 1  // 切換到下一個單位
        }

        // 格式化輸出，保留兩位小數以及對應的單位
        return String(format: "%.2f %@B", fileSize, units[index])
    }

    /// 將日期轉換為字串
    /// - Parameters:
    ///   - date: 日期
    ///   - style: 日期格式化樣式，預設為完整樣式
    ///   - locale: 地區，預設為當前地區
    /// - Returns: 格式化後的日期字串
    func dateToString(
        date: Date, style: DateFormatter.Style = DateFormatter.Style.full,
        locale: Locale = Locale.current
    ) -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = locale  // 設定地區
        dateFormatter.dateStyle = style  // 設定日期顯示樣式
        return dateFormatter.string(from: date)  // 將日期轉換成字串
    }

    /// 從檔案路徑中提取副檔名
    /// - Parameters:
    ///   - path: 檔案路徑
    /// - Returns: 副檔名字串
    func getExtension(fromPath path: String) -> String {
        let fileName: String = URL(fileURLWithPath: path).lastPathComponent  // 獲取檔名稱
        let components: [String] = fileName.components(separatedBy: ".")  // 將檔名稱以"."分隔
        guard components.count > 1 else {  // 確保有副檔名
            return ""
        }
        return components.last ?? ""  // 返回最後一個元素（副檔名）
    }

    /// 根據副檔名獲取圖示名稱
    /// - Parameters:
    ///   - extName: 副檔名
    /// - Returns: 圖示名稱字串
    func getIconName(extName: String) -> String {
        var iconName: String = "doc"  // 預設圖示名稱
        let lowercasedExt = extName.lowercased()  // 將副檔名轉為小寫

        switch lowercasedExt {
        case "heif", "jpg", "jpeg", "raw", "png", "gif", "tiff", "jfif":
            // https://support.apple.com/en-us/108314
            iconName = "photo"  // 圖片類圖示
        case "hevc", "mp4", "mov":
            iconName = "video"  // 影片類圖示
        default:
            break  // 其他檔案型別使用預設圖示
        }
        return iconName
    }

    /// 從影片路徑中獲取影片縮圖
    /// - Parameters:
    ///   - path: 影片路徑
    /// - Returns: 影片縮圖（UIImage）或nil
    func videoThumbnail(from path: String) -> UIImage? {
        let videoURL: URL = URL(fileURLWithPath: path)  // 影片路徑
        let asset: AVAsset = AVAsset(url: videoURL)  // 建立AVAsset物件
        let imageGenerator: AVAssetImageGenerator = AVAssetImageGenerator(
            asset: asset)
        imageGenerator.appliesPreferredTrackTransform = true  // 應用影片的旋轉設定

        let time: CMTime = CMTime(seconds: 0, preferredTimescale: 600)  // 取第0秒的縮圖
        var actualTime: CMTime = CMTime()  // 實際的截圖時間

        // 嘗試獲取CGImage，若失敗則返回nil
        guard let imageRef: CGImage = try? imageGenerator.copyCGImage(
            at: time, actualTime: &actualTime) else {
            return nil
        }

        return UIImage(cgImage: imageRef)  // 將CGImage轉換成UIImage
    }

    /// 在檔案資訊陣列中查詢指定路徑的索引
    /// - Parameters:
    ///   - fileInfos: 檔案資訊陣列
    ///   - path: 要查詢的檔案路徑
    /// - Returns: 索引值（若找到）或-1（若未找到）
    func indexFileInfoModel(fileInfos: [FileInfoModel], path: String) -> Int {
        var i: Int = 0
        for fileInfo: FileInfoModel in fileInfos {  // 迭代檔案資訊陣列
            if fileInfo.path == path {  // 比對路徑是否一致
                return i  // 若一致，返回索引值
            }
            i = i + 1
        }
        return -1  // 找不到時返回-1
    }
}
