//
//  TopicCollectionViewCell.swift
//  Damkla
//
//  Created by Thong Tran on 9/3/17.
//  Copyright © 2017 ThongApp. All rights reserved.
//

import UIKit

class TopicCollectionViewCell: UICollectionViewCell {
   
    var topic: Topics! {
        didSet {
            updateUI()
        }
    }
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var title : UILabel!
    private func updateUI() {
            title.text = topic.title
            featuredImageView.image = topic.image
    }
}
