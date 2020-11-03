//
//  ESStakeCoinDetailsCalculateCell.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 01.11.2020.
//

import UIKit

protocol ESStakeCoinDetailsCalculatorCellDelegate {
    func openCalculatorPressed()
}

class ESStakeCoinDetailsCalculatorCell: UITableViewCell {

    var delegate: ESStakeCoinDetailsCalculatorCellDelegate?
    
    @IBAction func openCalculatorPressed() {
        delegate?.openCalculatorPressed()
    }
    
}
