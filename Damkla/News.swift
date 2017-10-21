//
//  News.swift
//  Damkla
//
//  Created by Thong Tran on 9/3/17.
//  Copyright © 2017 ThongApp. All rights reserved.
//

import Foundation
import algorithmia
import SwiftyJSON
import ReadabilityKit
class News {
    var newsImageURL: String!
    var title : String!
    var description: String!
    var contextURL: String!
    var text: String!
    func content_text () -> String {
        var textOut = ""
            let url = URL(string: self.contextURL)
            Readability.parse(url: url!) { (data) in
                let text = data?.text?.components(separatedBy: "Risk Briefing                                                                                                                      \n            ")
                let input = text?[1]
                textOut = input!
        }
        return textOut
    }
    
    func summary_text () {
        DispatchQueue.main.async {
            let input = self.content_text()
            let client = Algorithmia.client(simpleKey: "sim4t+I0YqoqesIbWuP6QkGw2uC1")
            let summarizer = client.algo(algoUri: "nlp/Summarizer/0.1.3")
            summarizer.pipe(text: input) { resp, error in
                if (error == nil) {
                    self.text = resp.getText()
                }
            }
        }
    }
    init(json: JSON) {
            self.title = json["title"].stringValue
            self.description = json["description"].stringValue
            self.contextURL = json["url"].stringValue
            self.newsImageURL = json["urlToImage"].stringValue
 
    
    }
}
