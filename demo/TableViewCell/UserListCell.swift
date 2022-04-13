//
//  UserListCell.swift
//  demo
//
//  Created by CMTech on 12/4/22.
//

import UIKit

class UserListCell: UITableViewCell {
    
    @IBOutlet weak var nameLbl: UILabel!
    
    @IBOutlet weak var phoneLbl: UILabel!
    
    @IBOutlet weak var companyLbl: UILabel!
    
    @IBOutlet weak var starImg: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        self.selectionStyle = .none
        
    }
    
    
    
}


extension UIButton
{
    func addBorder(width:CGFloat,color:UIColor,cornerRadius:CGFloat)
    {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}
