//
//  FavoriteViewController.swift
//  Damkla
//
//  Created by Thong Tran on 9/5/17.
//  Copyright © 2017 ThongApp. All rights reserved.
//

import UIKit
import KVCardSelectionVC
import MessageUI

class FavoriteViewController: KVCardSelectionViewController , MFMailComposeViewControllerDelegate{
    
    var cards: [Source]? {
        didSet {
            reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        selectionAnimationStyle = .fade
        
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*
         NOTE: If you are displaying an instance of `KVCardSelectionViewController` within a `UINavigationController`, you can use the code below to hide the navigation bar. This isn't required to use `KVCardSelectionViewController`, but `KVCardSelectionViewController` was designed to be used without a UINavigationBar.
         let image = UIImage()
         let navBar = navigationController?.navigationBar
         navBar?.setBackgroundImage(image, for: .default)
         navBar?.shadowImage = image
         */
        
        // Load your dynamic CardPresentable data
        cards = [
            Source(name: "BBC News", photoURL: "https://21stcenturywire.files.wordpress.com/2012/11/bbc-logo2.jpg?w=320&h=171", address: "123 Main St", city: "Atlanta", state: "GA", zip: 12345, email : "londonnews@bbc.co.uk"),
            Source(name: "ESPN", photoURL: "https://i.pinimg.com/originals/19/e6/00/19e60024fb585567a1bf040bf113ca05.jpg", address: "234 Main St", city: "Atlanta", state: "GA", zip: 12345, email : "support@espn.go.com"),
            Source(name: "CNBC", photoURL: "https://lh3.googleSourcecontent.com/z1UDoxRq7-yLISA0gYHYjbxygwTFGQrEe84Tvu9sRi8fA8nmb6MGRu0hU-BJx1i2rdI=w300", address: "456 Main St", city: "Atlanta", state: "GA", zip: 12345, email: "distribution@CNBC.com"),
            Source(name: "CNN News", photoURL: "http://i.cdn.cnn.com/cnn/.e/img/3.0/global/misc/cnn-logo.png", address: "567 Main St", city: "Atlanta", state: "GA", zip: 12345, email : "ad"),
            Source(name: "Bloomberg", photoURL: "https://pbs.twimg.com/profile_images/714946924105883648/4fgNVF4H.jpg", address: "678 Main St", city: "Atlanta", state: "GA", zip: 12345, email : "sad")
        ]
    }
}


extension FavoriteViewController: KVCardSelectionViewControllerDataSource{
    public func cardSelectionViewController(_ cardSelectionViewController: KVCardSelectionViewController, cardForItemAtIndexPath indexPath: IndexPath) -> CardPresentable {
        return cards![indexPath.row]

    }
    func numberOfCardsForCardSelectionViewController(_ cardSelectionViewController: KVCardSelectionViewController) -> Int {
        return cards!.count
    }
}
extension FavoriteViewController: KVCardSelectionViewControllerDelegate {
    
    func cardSelectionViewController(_ cardSelectionViewController: KVCardSelectionViewController, didSelectCardAction cardAction: CardAction, forCardAtIndexPath indexPath: IndexPath) {
        let card = cards?[(indexPath as NSIndexPath).row]
        if let action = card?.actionOne , action.title == cardAction.title {

            print("----------- \nCard action fired! \nAction Title: \(cardAction.title) \nIndex Path: \(indexPath)")
        }
        if let action = card?.actionTwo , action.title == cardAction.title {
            // Sending email 
            send_email()
            print("----------- \nCard action fired! \nAction Title: \(cardAction.title) \nIndex Path: \(indexPath)")
        }
    }
    
    func cardSelectionViewController(_ cardSelectionViewController: KVCardSelectionViewController, didSelectDetailActionForCardAtIndexPath indexPath: IndexPath) {
        print("CARD SELECTED for \(indexPath)")
                    let storyBoard = UIStoryboard(name: "favoriteVC", bundle: nil)
    }
    
    
    
    func send_email () {
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        composeVC.setToRecipients(["ctr89josh@gmail.com"])
        composeVC.setSubject("StoryBook Feedback")
        composeVC.setMessageBody("Hey Josh! Here's my feedback.", isHTML: false)
        
        // Present the view controller modally.
        
        self.present(composeVC, animated: true, completion: nil)
    }
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        // Check the result or perform other tasks.
        
        // Dismiss the mail compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
}
struct Source {
    var name: String
    var photoURL: String
    var address: String
    var city: String
    var state: String
    var zip: Int
    var email: String
}

extension Source: CardPresentable {
    var dialLabel: String {
        guard let lastString = titleText.components(separatedBy: " ").last else {return ""}
        return String(lastString[lastString.startIndex])
    }
    var imageURLString: String {
        return photoURL
    }
    var placeholderImage: UIImage? {
        return UIImage(named: "default")
    }
    var titleText: String {
        return name
    }
    var detailTextLineOne: String {
        return address
    }
    var detailTextLineTwo: String {
        return "\(city), \(state) \(zip)"
    }
    var actionOne: CardAction? {
        return CardAction(title: "Listen")
    }
    var actionTwo: CardAction? {
        return CardAction(title: "Email")
    }
    
}
