//
//  DocumentsManager.swift
//  iuimport
//
//  Created by 神楽坂雅詩 on 2024/3/2.
//

import Foundation

class FileInfoModel: Identifiable {
    var name: String = ""
    var path: String = ""
    var size: Int = 0
    var creation: Date = Date()
    var modification: Date = Date()
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
                allFiles.append(model)
            }
        } catch {
            print("Error getting contents of directory: \(error)")
            return []
        }
        print(allFiles)
        return allFiles
    }
}
