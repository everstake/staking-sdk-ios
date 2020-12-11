//
//  ESStakeCoinDetailsCalculateCell.swift
//  EverstakeSDK
//
//  Created by Alex Koziaruk on 01.11.2020.
//

import UIKit

protocol ESStakeCoinDetailsCalculatorCellDelegate: AnyObject {
    func openCalculatorButtonPressed()
}

class ESStakeCoinDetailsCalculatorCell: UITableViewCell {

    weak var delegate: ESStakeCoinDetailsCalculatorCellDelegate?
    
    @IBAction func openCalculatorButtonPressed() {
        delegate?.openCalculatorButtonPressed()
    }
    
}
