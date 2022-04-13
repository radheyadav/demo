//
//  ProfileVC.swift
//  demo
//
//  Created by CMTech on 13/4/22.
//

import UIKit
import Foundation

class ProfileVC: UIViewController {
    var imagePicker = UIImagePickerController()
    var imaegPath = String()
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileBtn.addBorder(width: 1.0, color: .blue, cornerRadius: 8)
        profileImage.image = UIImage(named: "user")
        
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 100
        profileImage.clipsToBounds = true
        profileImage.layer.borderColor = UIColor.black.cgColor
        profileImage.layer.borderWidth = 1.0
        
        if let userImage = UserDefaults.standard.value(forKey: "ProfileImage")
        {
            profileImage.image = UIImage(named: Utility.getPhotofolder().stringByAppendingPathComponent(pathComponent: userImage as! String))
        }
        else
        {
            profileImage.image = UIImage(named: "user")
        }
        
    }
    
    
    @IBAction func changeBtnClicked(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.tabBarController?.tabBar.isHidden = true
            //If you dont want to edit the photo then you can set allowsEditing to false
            // imagePicker.allowsEditing = true
            imagePicker.delegate = self
            imagePicker.modalPresentationStyle = .overCurrentContext
            self.present(imagePicker, animated: true, completion: nil)
            
            
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        //imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.modalPresentationStyle = .overCurrentContext
        self.present(imagePicker, animated: true, completion: nil)
        
    }
}

extension ProfileVC:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        let StrquestionDate = "\(Date().timeIntervalSince1970).jpg)"
        
        
        var insertPhoto = false
        if let editedImage = info[.originalImage] as? UIImage{
            self.profileImage.image = editedImage
            UserDefaults.standard.setValue(StrquestionDate, forKey: "ProfileImage")
            insertPhoto = Utility.saveImageDocumentDirectory(photo: editedImage, photoUrl: StrquestionDate)
            if(insertPhoto)
            {
                imaegPath  =  Utility.getPhotofolder().stringByAppendingPathComponent(pathComponent: StrquestionDate)
            }
            
            //            print("imagepath is \(imaegpath)")
            
            
        }
        
        
        
        
        //Dismiss the UIImagePicker after selection
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
        
    }
}
