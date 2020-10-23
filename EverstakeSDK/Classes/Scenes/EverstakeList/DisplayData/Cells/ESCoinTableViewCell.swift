//
//  ESCoinTableViewCell.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 22.10.2020.
//

import UIKit

class ESCoinTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var disclosureImageView: UIImageView!
    @IBOutlet weak var coinContentView: UIView!
    @IBOutlet weak var separatorViewHeightConstraint: NSLayoutConstraint!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        separatorViewHeightConstraint.constant = 0.5
    }

    public override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
