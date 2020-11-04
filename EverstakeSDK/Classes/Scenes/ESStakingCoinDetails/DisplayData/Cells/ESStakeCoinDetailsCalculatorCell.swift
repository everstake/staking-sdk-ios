//
//  ESStakeCoinDetailsCalculateCell.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 01.11.2020.
//

import UIKit

protocol ESStakeCoinDetailsCalculatorCellDelegate {
    func openCalculatorButtonPressed()
}

class ESStakeCoinDetailsCalculatorCell: UITableViewCell {

    var delegate: ESStakeCoinDetailsCalculatorCellDelegate?
    
    @IBAction func openCalculatorButtonPressed() {
        delegate?.openCalculatorButtonPressed()
    }
    
}
