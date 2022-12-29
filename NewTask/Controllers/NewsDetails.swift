//
//  NewsDetails.swift
//  NewTask
//
//  Created by mohsen on 27/12/2022.
//

import UIKit
import Kingfisher

class NewsDetails: UIViewController {
    
    var newsDetails : Articles!

    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Author: UILabel!
    @IBOutlet weak var descrebtion: UITextView!
    @IBOutlet weak var titleDetails: UILabel!
    @IBOutlet weak var ImageDetails: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        NewsDetails()
        // Do any additional setup after loading the view.
    }
    
    private func NewsDetails(){
        ImageDetails.kf.setImage(with:newsDetails.urlToImage?.asUrl)
        titleDetails.text = newsDetails.title
        descrebtion.text = newsDetails.description
        Author.text = newsDetails.author

        
         let newDateString = newsDetails.publishedAt?.convertDateString()
         Time.text = newDateString
        
    }
 

}
