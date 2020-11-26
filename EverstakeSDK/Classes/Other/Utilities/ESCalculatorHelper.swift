//
//  ESCalculatorHelper.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 18.11.2020.
//

import Foundation

class ESCalculatorHelper {
    
    struct Result {
        let perYear: Double
        let perMonth: Double
        let perDay: Double
    }
    
    var amount: Double = 0
    var periodScale: Double = 0
    var includeReinvestment: Bool = false
    
    init(amount: Double,
         periodScale: Double,
         includeReinvestment: Bool) {
    
        self.amount = amount
        self.periodScale = periodScale
        self.includeReinvestment = includeReinvestment
    }

    public static func getCalculations(model: ESSharedModel.Coin,
                                       amount: Double,
                                       includeValidatorFee: Bool = false,
                                       // TODO: Add validator info
                                       includeReinvestment: Bool = false) -> ESCalculatorHelper.Result {
        
        guard let yieldPercent = Double(model.yieldPercent ?? "0"),
              let periodSeconds = Int(model.yieldInterval ?? "0") else {
            return Result(perYear: 0, perMonth: 0, perDay: 0)
        }
        
        // TODO: includeValidatorFee == true case
        let periodScale = (includeValidatorFee ? 0 : yieldPercent) * pow(10, -2)

        let calcHelper = ESCalculatorHelper(amount: amount,
                                            periodScale: periodScale,
                                            includeReinvestment: includeReinvestment)
        

        let perYear = calcHelper.calculate(duration: ESCalculatorHelper.Constants.yearInSeconds,
                                           periodDuration: periodSeconds)
        
        let perMonth = calcHelper.calculate(duration: ESCalculatorHelper.Constants.monthInSeconds,
                                            periodDuration: periodSeconds)
        
        let perDay = calcHelper.calculate(duration: ESCalculatorHelper.Constants.dayInSeconds,
                                          periodDuration: periodSeconds)
        
        return Result(perYear: perYear, perMonth: perMonth, perDay: perDay)
    }
    
    private func calculate(duration: Int, periodDuration: Int) -> Double {
        return calculate(periodCount: Double(duration) / Double(periodDuration))
    }
    
    private func calculate(periodCount: Double) -> Double {
        var periodIncome = 0.0
        
        if (includeReinvestment) {
            var count = periodCount
            while (count > 0) {
                let periodSize = min(count, 1)
                let periodAmount = amount + periodIncome
                periodIncome += periodAmount * periodScale * periodSize
                count -= periodSize
            }
        } else {
            periodIncome = amount * periodScale * periodCount
        }
        
        return periodIncome.rounded(toPlaces: 5)
    }

    private struct Constants {
        static let dayInSeconds = 60 * 60 * 24
        static let monthInSeconds = dayInSeconds * 30
        static let yearInSeconds = dayInSeconds * 365
    }
}
