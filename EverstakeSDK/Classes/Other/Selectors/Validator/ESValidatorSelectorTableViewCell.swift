//
//  ESValidatorSelectorTableViewCell.swift
//  EverstakeSDK
//
//  Created by Alex Koziaruk on 19.11.2020.
//

import UIKit

class ESValidatorSelectorTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var checkImageView: UIImageView!
    @IBOutlet weak var reliableContainerView: UIView!
    @IBOutlet weak var gradientView: ESGradientView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gradientView.setGradientColors(one: UIColor(hex: "#C4C4C4")!.withAlphaComponent(0),
                                       two: UIColor(hex: "#7CB518")!.withAlphaComponent(0.1))
        gradientView.showGradient(true)
    }
}
