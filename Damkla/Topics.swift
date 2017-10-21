//
//  Topics.swift
//  Damkla
//
//  Created by Thong Tran on 9/3/17.
//  Copyright © 2017 ThongApp. All rights reserved.
//

import Foundation
import UIKit
class Topics {
    
    var title = ""
    var id = ""
    var image: UIImage!
    
    init(title: String , image : UIImage, id : String) {
        self.title = title
        self.image = image
        self.id = id
    }
    static func createTopics () -> [Topics]
    {
        return [
            Topics(title: "Business", image: UIImage(named: "business")!,id : "business"),
            Topics(title: "Technology", image: UIImage(named: "E-Tech")!, id: "technology"),
            Topics(title: "Entertainment", image: UIImage(named: "entertainment")!, id:"entertainment"),
            Topics(title: "Gaming", image: UIImage(named: "gamming")!, id: "gaming"),
            Topics(title: "Sport", image: UIImage(named: "sport")!, id : "sport"),
            Topics(title: "Music", image: UIImage(named: "music")!, id : "music")
        ]
    }
}
