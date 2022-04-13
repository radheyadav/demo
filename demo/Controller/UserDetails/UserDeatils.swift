//
//  UserDeatils.swift
//  demo
//
//  Created by CMTech on 12/4/22.
//

import UIKit

class UserDeatils: UIViewController {
    
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var companyLbl: UILabel!
    @IBOutlet weak var phonelbl: UILabel!
    @IBOutlet weak var websiteLbl: UILabel!
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var starImg: UIImageView!
    
    var userDetails: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        linkView()
    }
    
    @IBAction func favToggle(_ sender: Any) {
        if let tempBool = userDetails?.isfav
        {
            
            userDetails!.isfav = !tempBool
            
            
            
        }
        else
        {
            userDetails!.isfav = true
        }
        if(globalID.contains(userDetails!.id!))
        {
            globalID.remove(at: globalID.firstIndex(of: userDetails!.id!)!)
        }
        else
        {
            globalID.append(userDetails!.id!)
        }
        linkView()
    }
    
    func linkView()
    {
        nameLbl.text = userDetails!.name
        userNameLbl.text = userDetails!.username ?? ""
        addressLbl.text = userDetails!.address!.suite! + "," + userDetails!.address!.street! + "," + userDetails!.address!.city! + "," + userDetails!.address!.zipcode!
        companyLbl.text = userDetails!.company?.name ?? ""
        phonelbl.text = userDetails!.phone ?? ""
        websiteLbl.text = userDetails!.website ?? ""
        
        if(userDetails!.isfav ?? false)
        {
            
            
            starImg.image = UIImage(systemName: "star.fill")
            startBtn.setTitle("Unmark Star", for: .normal)
        }
        else
        {
            starImg.image =  UIImage(systemName: "star")
            startBtn.setTitle("Mark Star", for: .normal)
        }
        startBtn.addBorder(width: 1.0, color: .blue, cornerRadius: 8.0)
    }
    
    
}
