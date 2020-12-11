//
//  ESCache.swift
//  EverstakeSDK
//
//  Created by Alex Koziaruk on 28.10.2020.
//

import Foundation

class ESCache {
    
    //MARK: Public

    public static var shared = ESCache()
    
    public func getDataFor(_ path: String, successWith: @escaping (Data) -> Void) {
        if let url = cacheURLFor(path) {
            if FileManager.default.fileExists(atPath: url.path) {
                do {
                    let data = try Data(contentsOf: url)
                    successWith(data)
                } catch {
                    print("ESCache: Failed to get data")
                }
            }
        }
    }
    
    public func save(_ data: Data, for path: String) {
        if let url = cacheURLFor(path) {
            do {
                try data.write(to: url)
            } catch {
                print("ESCache: Failed to save data")
            }
        }
    }
    
    //MARK: Private
    
    private func cacheURLFor(_ path: String) -> URL? {
        if let directory = FileManager.default.urls(for: .documentDirectory,
                                                    in: .userDomainMask).first {
            return directory.appendingPathComponent(path)
        }
        return nil
    }
    
}
