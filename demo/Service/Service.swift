//
//  Service.swift
//  demo
//
//  Created by CMTech on 12/4/22.
//

import UIKit

class Service: NSObject {
    
    
    static let shareInstance = Service()
    
    func getData(urlString:String,completion: @escaping(Data?, Error?) -> ()){
        
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error{
                completion(nil,err)
                print("Loading data error: \(err.localizedDescription)")
            }else{
                guard let data = data else { return }
                completion(data,nil)
                
            }
        }.resume()
    }
    
    
    
}

