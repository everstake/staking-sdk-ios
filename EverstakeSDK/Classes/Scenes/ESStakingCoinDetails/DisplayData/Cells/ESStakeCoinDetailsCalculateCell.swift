//
//  ESStakeCoinDetailsCalculateCell.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 01.11.2020.
//

import UIKit

protocol ESStakeCoinDetailsCalculateCellDelegate {
    func openCalculatorPressed()
}

class ESStakeCoinDetailsCalculatorCell: UITableViewCell {

    var delegate: ESStakeCoinDetailsCalculateCellDelegate?
    
    @IBAction func openCalculatorPressed() {
        delegate?.openCalculatorPressed()
    }
    
}
