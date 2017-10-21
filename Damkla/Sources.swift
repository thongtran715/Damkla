//
//  Sources.swift
//  Damkla
//
//  Created by Thong Tran on 9/3/17.
//  Copyright © 2017 ThongApp. All rights reserved.
//

import Foundation
import SwiftyJSON
class Sources
{
    var source_identifier : String!
    var category: String!
    var language: String!
    init(json : JSON) {
            self.source_identifier = json["id"].stringValue
            self.category = json["category"].stringValue
            self.language = json["language"].stringValue
    }
}
