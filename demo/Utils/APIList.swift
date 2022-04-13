//
//  APIList.swift
//  demo
//
//  Created by CMTech on 12/4/22.
//

import UIKit

class APIList: NSObject {
    
    struct WebServices
    {
        static let userList = "https://jsonplaceholder.typicode.com/users"
        static var imageName = "user"
        static var youtubeVideoID = "_7b1647tH74"
    }
    
    
    
}

class Utility : NSObject
{
    class func createPhotoDirectory(){
        
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Demo")
        if !fileManager.fileExists(atPath: paths){
            try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
        }else{
            print("Already dictionary created.")
        }
    }
    
    
    class func getPhotofolder() -> String{
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent("Demo")
        if !fileManager.fileExists(atPath: paths){
            try! fileManager.createDirectory(atPath: paths, withIntermediateDirectories: true, attributes: nil)
            
        }else{
            print("Already dictionary created.")
        }
        
        return  paths
    }
    
    class func saveImageDocumentDirectory(photo : UIImage, photoUrl : String) -> Bool{
        
        let fileManager = FileManager.default
        
        let paths =  Utility.getPhotofolder().stringByAppendingPathComponent(pathComponent: photoUrl)
        print("image ka path \(paths)")
        if !fileManager.fileExists(atPath: paths){
            print("file already exits \(paths)")
            let imageData = photo.jpegData(compressionQuality: 0.5)
            fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
            
            if !fileManager.fileExists(atPath: paths){
                return false
            }else{
                return true
            }
            
        }else{
            print(paths)
            let imageData = photo.jpegData(compressionQuality: 0.5)
            fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
            if !fileManager.fileExists(atPath: paths){
                return false
            }else{
                return true
            }
            
        }
        
        
    }
}


extension String {
    func stringByAppendingPathComponent(pathComponent: String) -> String {
        return (self as NSString).appendingPathComponent(pathComponent)
    }
}

extension UIView {
    
    
    func fontsize() -> CGFloat
    {  var size: CGFloat!
        let dcheck = UIDevice.current.userInterfaceIdiom
        if(dcheck == .pad)
        {
            size = 20.0
        }
        else
        {
            size = 14
            
        }
        return size
    }
    
    
    func setCellShadow() {
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 1.0
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.cornerRadius = 3
    }
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat,
                paddingRight: CGFloat, width: CGFloat = 0, height: CGFloat = 0,isActive: Bool = true) {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = isActive
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = isActive
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = isActive
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = isActive
        }
        
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = isActive
        }
        
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = isActive
        }
    }
    
    
    
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        return topAnchor
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.leftAnchor
        }
        return leftAnchor
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        return bottomAnchor
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *) {
            return safeAreaLayoutGuide.rightAnchor
        }
        return rightAnchor
    }
    
}
