//
//  MenuCell.swift
//  demo
//
//  Created by CMTech on 13/4/22.
//

import UIKit

class MenuCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        self.selectionStyle = .none
    }
    
    
    
}
