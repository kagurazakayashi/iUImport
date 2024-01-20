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
  /// 檔案名稱
  var name: String = ""
  /// 檔案路徑
  var path: String = ""
  /// 檔案大小（單位：位元組）
  var size: Int = 0
  /// 建立日期
  var creation: Date = Date()
  /// 修改日期
  var modification: Date = Date()
  /// 檔案狀態（猜測用途，可能與檔案同步或上傳有關）
  var status: Int8 = 0
}

class DocumentsManager {
  let fileManager: FileManager = FileManager.default

  func getDocumentsFiles() -> [FileInfoModel] {
    // 檢查是否能取得 Documents 資料夾網址
    guard
      let documentDirectoryURL: URL = FileManager.default.urls(
        for: .documentDirectory, in: .userDomainMask
      )
      .first
    else { return [] }

    // 取得 Documents 資料夾路徑
    let documentPath: String = documentDirectoryURL.path

    // 轉換路徑為網址格式
    guard let documentURL: URL = URL(string: documentPath) else { return [] }

    // 宣告存放檔案資訊的陣列
    var allFiles: [FileInfoModel] = []

    // 試著讀取 Documents 資料夾下的檔案
    do {
      let files: [String] = try FileManager.default.contentsOfDirectory(atPath: documentPath)

      // 逐一處理每個檔案
      for file: String in files {
        let model: FileInfoModel = FileInfoModel()
        model.name = file  // 檔案名稱
        let fullURL: URL = documentURL.appendingPathComponent(file)  // 組合完整檔案網址
        model.path = fullURL.path  // 完整檔案路徑

        // 取得檔案屬性
        let attributes: [FileAttributeKey: Any] = try FileManager.default.attributesOfItem(
          atPath: model.path)
        model.size = attributes[.size] as! Int  // 檔案大小
        model.creation = attributes[.creationDate] as! Date  // 建立日期
        model.modification = attributes[.modificationDate] as! Date  // 修改日期

        allFiles.append(model)  // 將檔案資訊加入陣列
      }
    } catch {  // 若發生錯誤
      print("讀取資料夾內容時發生錯誤: \(error)")
      return []  // 回傳空陣列
    }

    return allFiles  // 回傳包含所有檔案資訊的陣列
  }

  func formatFileSize(size: Int, base: Double = 1024.0) -> String {
    let units: [String] = ["", "K", "M", "G", "T", "P", "E"]  // 檔案大小單位
    var fileSize: Double = Double(size)  // 檔案大小（位元組）
    var index: Int = 0  // 單位索引

    // 持續迴圈，直到檔案大小小於單位基準或是已達最大單位
    while fileSize >= base && index < units.count - 1 {
      fileSize /= base  // 將檔案大小除以基準進行單位換算
      index += 1  // 切換到下一個單位
    }

    // 格式化輸出，保留兩位小數以及對應的單位
    return String(format: "%.2f %@B", fileSize, units[index])
  }

  func dateToString(
    date: Date, style: DateFormatter.Style = DateFormatter.Style.full,
    locale: Locale = Locale.current
  ) -> String {
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.locale = locale  // 設定地區
    dateFormatter.dateStyle = style  // 設定日期顯示樣式
    return dateFormatter.string(from: date)  // 將日期轉換成字串
  }

  func getExtension(fromPath path: String) -> String {
    let fileName: String = URL(fileURLWithPath: path).lastPathComponent  // 取得檔案名稱
    let components: [String] = fileName.components(separatedBy: ".")  // 將檔案名稱以 "." 分隔
    guard components.count > 1 else {  // 確保有副檔名
      return ""
    }
    return components.last ?? ""  // 回傳最後一個元素（副檔名）
  }

  func getIconName(extName: String) -> String {
    var iconName: String = "doc"  // 預設圖示名稱
    switch extName {
    case "heif", "jpg", "jpeg", "raw", "png", "gif", "tiff", "jfif":
      // https://support.apple.com/en-us/108314
      iconName = "photo"  // 圖片類圖示
      break
    case "hevc", "mp4", "mov":
      iconName = "video"  // 影片類圖示
      break
    default:
      break  // 其他檔案類型使用預設圖示
    }
    return iconName
  }

  func videoThumbnail(from path: String) -> UIImage? {
    let videoURL: URL = URL(fileURLWithPath: path)  // 影片路徑
    let asset: AVAsset = AVAsset(url: videoURL)  // 建立 AVAsset 物件
    let imageGenerator: AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
    imageGenerator.appliesPreferredTrackTransform = true  // 套用影片的旋轉設定

    let time: CMTime = CMTime(seconds: 0, preferredTimescale: 600)  // 取第 0 秒的縮圖
    var actualTime: CMTime = CMTime()  // 實際的截圖時間

    // 嘗試擷取 CGImage，若失敗則回傳 nil
    guard let imageRef: CGImage = try? imageGenerator.copyCGImage(at: time, actualTime: &actualTime)
    else {
      return nil
    }

    return UIImage(cgImage: imageRef)  // 將 CGImage 轉換成 UIImage
  }

  func indexFileInfoModel(fileInfos: [FileInfoModel], path: String) -> Int {
    var i: Int = 0
    for fileInfo: FileInfoModel in fileInfos {  // 迭代檔案資訊陣列
      if fileInfo.path == path {  // 比對路徑是否一致
        return i  // 若一致，回傳索引值
      }
      i = i + 1
    }
    return -1  // 找不到時回傳 -1
  }

}
