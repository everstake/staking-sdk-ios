//
//  ESStakeCoinDetailsMainCell.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 29.10.2020.
//

import UIKit

protocol ESStakeCoinDetailsMainCellDelegate: AnyObject {
    func stakeButtonPressed()
}

class ESStakeCoinDetailsMainCell: UITableViewCell {

    weak var delegate: ESStakeCoinDetailsMainCellDelegate?
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var aprLabel: UILabel!
    @IBOutlet weak var serviceFeeLabel: UILabel!
    @IBOutlet weak var serviceFeeContainer: UIView!
    
    @IBAction func stakeButtonPressed() {
        delegate?.stakeButtonPressed()
    }
    
}
