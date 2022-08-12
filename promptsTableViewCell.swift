//
//  promptsTableViewCell.swift
//  Mini Challenge 1 Team 4
//
//  Created by Catharina Adinda Mega Cahyani on 07/04/22.
//

import UIKit

class promptsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
//    label untuk comment
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var borderView: UIView!
    
    @IBOutlet weak var tanggalLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        borderView.layer.cornerRadius = 10
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor.black.cgColor
        
        label.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
