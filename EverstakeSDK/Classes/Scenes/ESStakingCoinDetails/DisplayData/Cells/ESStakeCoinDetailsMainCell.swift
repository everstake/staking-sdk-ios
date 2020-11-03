//
//  ESStakeCoinDetailsMainCell.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 29.10.2020.
//

import UIKit

protocol ESStakeCoinDetailsMainCellDelegate {
    func stakeButtonPressed()
}

class ESStakeCoinDetailsMainCell: UITableViewCell {

    var delegate: ESStakeCoinDetailsMainCellDelegate?
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var aprLabel: UILabel!
    @IBOutlet weak var serviceFeeLabel: UILabel!
    
    @IBAction func stakeButtonPressed() {
        delegate?.stakeButtonPressed()
    }
    
}
