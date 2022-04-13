//
//  ViewController.swift
//  demo
//
//  Created by CMTech on 12/4/22.
//

import UIKit
var globalID = [Int]()
class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, SlideMenuDelegate {
    
    @IBOutlet weak var userTable : UITableView!
    
    private var userListData = UserViewModel()
    
    private var userModel = Users()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton(title: "Demo")
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.orange]
        userTable.delegate = self
        userTable.dataSource = self
        userTable.register(UINib(nibName: "UserListCell", bundle: nil), forCellReuseIdentifier: "UserListCell")
        
        userListData.userList.bind{ [weak self] _ in
            DispatchQueue.main.async {
                self?.userTable.reloadData()
            }
            
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchUserData()
    }
    
    func fetchUserData()
    {
        Service.shareInstance.getData(urlString: APIList.WebServices.userList)
        {(data,error) in
            if(error == nil)
            {
                guard let tempUserData = data else {
                    return
                }
                do{
                    
                    self.userModel = try JSONDecoder().decode(Users.self, from: tempUserData)
                    
                    self.userListData.userList.value = self.userModel
                    
                    
                }catch let jsonErr{
                    print("json error : \(jsonErr.localizedDescription)")
                }
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userListData.userList.value?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserListCell", for: indexPath) as! UserListCell
        if let tempData = userListData.userList.value?[indexPath.row]
        {
            
            cell.nameLbl.text = tempData.name
            cell.phoneLbl.text = "Phone No : " + (tempData.phone ?? "")! + "\nWebsite " + (tempData.website ?? "")!
            cell.companyLbl.text = tempData.company?.name ?? ""
            if(globalID.contains(tempData.id!))
            {
                cell.starImg.image = UIImage(systemName: "star.fill")
                userModel[indexPath.row].isfav = true
            }
            else
            {
                cell.starImg.image =  UIImage(systemName: "star")
                userModel[indexPath.row].isfav = false
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        let UserController = UserDeatils(nibName: "UserDeatils", bundle: nil)
        
        UserController.userDetails = userModel[indexPath.row]
        self.navigationController?.pushViewController(UserController, animated: true)
    }
    
    
    func addSlideMenuButton(title : String){
        
        
        let btnShowMenu = UIButton(type: .system)
        let img = UIImage(named: "menu-30x30.png")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        btnShowMenu.setImage(img, for: .normal)
        btnShowMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnShowMenu.addTarget(self, action: #selector(onSlideMenuButtonPressed(_:)), for:.touchUpInside)
        let customBarItem = UIBarButtonItem(customView: btnShowMenu)
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "  " + title
        label.textColor = UIColor(red: 7/255, green: 51/255, blue: 88/255, alpha: 1.0)
        let dcheck = UIDevice.current.userInterfaceIdiom
        if(dcheck == .pad) {
            label.font = UIFont.boldSystemFont(ofSize: 22)
        }
        else
        {
            label.font = UIFont.boldSystemFont(ofSize: 18)
        }
        label.textColor = UIColor.white
        
        label.frame = CGRect(x: xpoint(txt: btnShowMenu) + 20, y: 5, width: 300, height: 40)
        
        //self.navigationBar.barStyle = UIBarStyle.Black
        //  self.navigationBar.barStyle = UIBarStyle.Black
        
        let cust = UIBarButtonItem(customView: label)
        self.navigationItem.leftBarButtonItems = [customBarItem,cust]
        navigationController?.navigationBar.barTintColor = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 1)
        navigationController?.navigationItem.setHidesBackButton(true, animated:true)
        
        
    }
    
    @objc func onSlideMenuButtonPressed(_ sender : UIButton){
        print("clickedc")
        
        
        sender.isEnabled = false
        sender.tag = 10
        
        self.navigationItem.setHidesBackButton(true, animated:true)
        let menuVC  = MenuVC(nibName: "MenuVC", bundle: nil)
        
        menuVC.btnMenu = sender
        menuVC.delegate = self
        self.view.addSubview(menuVC.view)
        //self.addChild(menuVC)
        self.addChild(menuVC)
        menuVC.view.layoutIfNeeded()
        
        
        menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
        }, completion:nil)
        
    }
    
    func xpoint(txt : UIView) -> CGFloat
    {    let dcheck = UIDevice.current.userInterfaceIdiom
        var x = CGFloat()
        if (dcheck == .pad)
        {
            let txtview = txt
            x = txtview.frame.origin.x + txtview.frame.width + 1
            // return x
        }
        else
        {
            let txtview = txt
            x = txtview.frame.origin.x + txtview.frame.width + 5
            //return x
        }
        return x
    }
    
    func slideMenuItemSelectedAtIndex(_ index: Int32) {
        switch (index)
        {
        case 1:
            
            let profileVC = ProfileVC(nibName: "ProfileVC", bundle: nil)
            self.navigationController?.pushViewController(profileVC, animated: true)
            break
        case 2:
            let videoPlayer = YoutubevideoPlayer(nibName: "YoutubevideoPlayer", bundle: nil)
            self.navigationController?.pushViewController(videoPlayer, animated: true)
            break
        default:
            print("None")
        }
    }
}


