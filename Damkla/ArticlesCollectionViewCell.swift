//
//  ArticlesCollectionViewCell.swift
//  Damkla
//
//  Created by Thong Tran on 9/3/17.
//  Copyright © 2017 ThongApp. All rights reserved.
//

import UIKit

class ArticlesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var titleImageView: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    
    
    var article : News? {
        didSet {
                if let imageUrl = self.article?.newsImageURL, let title = self.article?.title {
                self.titleImageView.loadImageFromURl(url_name: imageUrl)
                self.labelTitle.text = title
                }
        }
    }
}
