//
//  ArticlesViewController.swift
//  Damkla
//
//  Created by Thong Tran on 9/3/17.
//  Copyright © 2017 ThongApp. All rights reserved.
//

import UIKit
import Alamofire
import BRYXBanner
import SwiftyJSON
import ReadabilityKit
class ArticlesViewController: UIViewController {

   // Attribute of Category 
    var category: String?
    var isSummary = false
    @IBOutlet var collectionView: UICollectionView!
    var newsArray = [News]()
    var sourcesArray = [Sources]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.find_sources_category(category!, "en")
    }
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
  func find_news_articles ( _ sourcesId : String){
        
        // Getting the articles related to specific Category and Sources
        DispatchQueue.main.async {
            Alamofire.request("https://newsapi.org/v1/articles?source=\(sourcesId)&sortBy=top&apiKey=739d5bd504254c82ad73ccd9805e5229").validate(statusCode: 200..<500).responseJSON { (response) in
                
                switch response.result{
                case .success:
                    if let value = response.result.value {
                        let json = JSON(value)
                        let news = json["articles"].arrayValue
                        for new in news {
                            
                            self.newsArray.append(News(json: new))
                            
                        }
                        self.collectionView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func find_sources_category ( _ category: String, _ language: String) {
        
        // Finding the sources to specific Category
        // Let's say search for technology
        Alamofire.request("https://newsapi.org/v1/sources?category=\(category)&language=\(language)&sortBy=latest&apiKey=739d5bd504254c82ad73ccd9805e5229").validate(statusCode: 200..<500).responseJSON { (response) in
            switch response.result
            {
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    let sources = json["sources"].arrayValue
                    for source in sources {
                        self.sourcesArray.append(Sources(json: source))
                    }
                    for source in self.sourcesArray{
                        if let id = source.source_identifier {
                        self.find_news_articles(id)
                        }
                    }
                }
                
            case .failure(let error):
                print(error)
                
            }
        }
        
    }

    @IBAction func switchBtn(_ sender: Any) {
        if switchOutlet.isOn != true{
            let banner = Banner(title: "Style of Listening", subtitle: "Summary", image: nil, backgroundColor: .brown, didTapBlock: nil)
                banner.dismissesOnTap = true
                banner.show(duration: 3.0)
                isSummary = true
            
        }
        else
        {
             let banner = Banner(title: "Style of Listening", subtitle: "Full", image: nil, backgroundColor: .brown, didTapBlock: nil)
                banner.dismissesOnTap = true
                banner.show(duration: 3.0)
                isSummary = false
        }
    }
    @IBOutlet var switchOutlet: UISwitch!
   
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "read-segue"
        {
            if let vc = segue.destination as? ListenViewController{
                let cell = sender as! ArticlesCollectionViewCell
                let indexPaths = self.collectionView.indexPath(for: cell)
                vc.new = newsArray[(indexPaths?.row)!]
                vc.isSummary = isSummary
           
                //vc.articleImageView.loadImageFromURl(url_name: newsArray[(indexPaths?.row)!].newsImageURL)
            }
        }
    }
}




extension ArticlesViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.newsArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "article-cell", for: indexPath) as! ArticlesCollectionViewCell
        cell.article = newsArray[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Here is the index")
        print(indexPath)
    }
}






