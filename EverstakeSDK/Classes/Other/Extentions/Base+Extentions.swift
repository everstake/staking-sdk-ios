//
//  Base+Extentions.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 18.11.2020.
//

import Foundation

extension Double {
    
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}
