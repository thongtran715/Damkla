//
//  Helper.swift
//  Damkla
//
//  Created by Thong Tran on 9/3/17.
//  Copyright © 2017 ThongApp. All rights reserved.
//

import Foundation
import UIKit

let imageCache =  NSCache<AnyObject, AnyObject>()
extension UIImageView{
    
    func loadImageFromURl ( url_name : String ){
        
        if let cachedImage = imageCache.object(forKey: url_name as AnyObject) as? UIImage{
            self.image = cachedImage
            return
        }
        
        
        let url = URL(string: url_name)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            DispatchQueue.main.async() { () -> Void in
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: url_name as AnyObject)
                    self.image = downloadedImage
                }
                
                
            }
        }).resume()
    }
    
}
