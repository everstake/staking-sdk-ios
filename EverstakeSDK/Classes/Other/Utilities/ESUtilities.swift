//
//  Utilities.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 22.10.2020.
//

import Foundation

class ESUtilities {
    
    static let shared = ESUtilities()
    
    var bundle: Bundle {
        return Bundle(for: EverstakeSDK.self)
    }
    
    static func decode<T>(_ type: T.Type, from data: Data) -> T? where T : Decodable {
        do {
            return try JSONDecoder().decode(type, from: data)
        } catch {
            print("Error during JSON serialization: \(error.localizedDescription)")
        }
        return nil
    }
    
    var statusBarHeight: CGFloat {
        let statusBarSize = UIApplication.shared.statusBarFrame.size
        return Swift.min(statusBarSize.width, statusBarSize.height)
    }
}
