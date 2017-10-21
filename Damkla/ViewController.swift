//
//  ViewController.swift
//  Damkla
//
//  Created by Thong Tran on 9/2/17.
//  Copyright © 2017 ThongApp. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import SwiftyJSON
import ReadabilityKit
import algorithmia
class ViewController: UIViewController {

    var newsArray = [News]()
    var sourcesArray = [Sources]()
    var topics = Topics.createTopics()
    
   // MARK - Images
    @IBOutlet weak var  collectionView: UICollectionView!
    @IBOutlet var imageBackground: UIImageView!

    
    
    
    /*
    @IBAction func listenButton(_ sender: Any) {
       /*
        let input = textView.text
        let client = Algorithmia.client(simpleKey: "sim4t+I0YqoqesIbWuP6QkGw2uC1")
        let summarizer = client.algo(algoUri: "nlp/Summarizer/0.1.3")
        summarizer.pipe(text: input) { resp, error in
            if (error == nil) {
                self.myUtterance = AVSpeechUtterance(string: resp.getText())
                self.myUtterance.rate = 0.5
                self.synth.speak(self.myUtterance)
                print(resp.getText())
            }
        }
 */
        for news in newsArray{
            print(news.title!)
            print(news.contextURL!)
        }
        let url = URL(string: "https://arstechnica.com/gaming/2017/09/review-dominate-the-solar-system-in-the-expanse-board-game/")
        Readability.parse(url: url!) { (data) in
                print(data?.text!)
        }
    }
 */

    override func viewDidLoad() {
        super.viewDidLoad()

        //find_sources_category("technology", "en")
        collectionView.delegate = self
  
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // Prepare for segue to initialize the article 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "article-segue" {
            if let navigationController = segue.destination as? UINavigationController {
            let articleController = navigationController.topViewController as! ArticlesViewController
                if let button = sender as? UIButton {
                    if let cell = button.superview?.superview as? UICollectionViewCell {
                        let indexPath = self.collectionView.indexPath(for: cell)
                        articleController.newsArray.removeAll()
                        articleController.sourcesArray.removeAll()
                        articleController.navigationItem.title = topics[(indexPath?.row)!].title
                        articleController.category = topics[(indexPath?.row)!].id
                    }
                }
            }
        
        }
    }
}


extension ViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topics.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Topics Cell", for: indexPath) as! TopicCollectionViewCell
        cell.topic = topics[indexPath.row]
        return cell
    }
    
    
}


// Delegate the scroll view
extension ViewController: UIScrollViewDelegate, UICollectionViewDelegate{
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
    }
}















