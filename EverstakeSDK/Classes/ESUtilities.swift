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
    
}
