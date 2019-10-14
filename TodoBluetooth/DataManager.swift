//
//  DataManager.swift
//  TodoBluetooth
//
//  Created by Grégoire Jacquin on 14/10/2019.
//  Copyright © 2019 Grégoire Jacquin. All rights reserved.
//

import Foundation

public class DataManager {
    //Get a Document Directory
    static fileprivate func getDocumentDirectory() -> URL {
        if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return url
        } else {
            fatalError("Unable to access document directory")
        }
    }
    
    //Save any kind of codable objects
    static func save<T:Codable>(_ object:T, with filename:String) {
        let url = DataManager.getDocumentDirectory().appendingPathComponent(filename, isDirectory: false)
        let encode = JSONEncoder()
        
        do{
            let data = try encode.encode(object)
            if FileManager.default.fileExists(atPath: url.path){
                try FileManager.default.removeItem(at: url)
            }
            FileManager.default.createFile(atPath: filename, contents: data, attributes: nil)
            
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    //Load any kind of codable objects
    static func load <T:Decodable>(_ filename:String,with type:T.Type) -> T {
        let url = DataManager.getDocumentDirectory().appendingPathComponent(filename, isDirectory: false)
        if !FileManager.default.fileExists(atPath: filename){
            fatalError("File not found at path \(url.path)")
        }
        if let data = FileManager.default.contents(atPath: url.path) {
            do {
                let model = try JSONDecoder().decode(type, from: data)
                return model
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("Data unavailable at path \(url.path)")
        }
    }
    //Load data from a file
    static func loadData (_ filename:String) -> Data? {
        let url = DataManager.getDocumentDirectory().appendingPathComponent(filename, isDirectory: false)
        if !FileManager.default.fileExists(atPath: filename){
            fatalError("File not found at path \(url.path)")
        }
        if let data = FileManager.default.contents(atPath: url.path) {
            return data
        } else {
            fatalError("Data unavailable at path \(url.path)")
        }
    }
    //Load all files from a directory
    static func loadAll <T:Decodable> (_ type:T.Type) -> [T] {
        do {
            let files = try FileManager.default.contentsOfDirectory(atPath: getDocumentDirectory().path)
            var modelObjects = [T]()
            for filename in files{
                modelObjects.append(load(filename, with: type))
            }
            return modelObjects
        } catch {
            fatalError("Could not load any files")
        }
    }
    //Delete a file
    static func delete(_ fileName:String) {
        let url = getDocumentDirectory().appendingPathComponent(fileName, isDirectory: false)
        if FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
            
    }
}
