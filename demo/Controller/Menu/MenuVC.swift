//
//  MenuVC.swift
//  demo
//
//  Created by CMTech on 13/4/22.
//

import UIKit

protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}

class MenuVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    var delegate : SlideMenuDelegate?
    var btnMenu : UIButton!
    @IBOutlet var tblMenuOptions : UITableView!
    
    @IBOutlet var btnCloseMenuOverlay : UIButton!
    var menuOptions = ["Profile","Video"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tblMenuOptions.delegate = self
        tblMenuOptions.dataSource = self
        tblMenuOptions.register(UINib(nibName: "MenuCell", bundle: nil), forCellReuseIdentifier: "MenuCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        cell.nameLbl.text = menuOptions[indexPath.row]
        cell.nameLbl.textColor = .black
      return cell
    }
    
    @IBAction func onCloseMenuClick(_ button:UIButton!){
        btnMenu.tag = 0
        if (self.delegate != nil) {
            var index = Int32(button.tag)
            if(button == self.btnCloseMenuOverlay){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
            
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let btn = UIButton(type: .custom)
        btn.tag = indexPath.row + 1
        self.onCloseMenuClick(btn)
    }
}
