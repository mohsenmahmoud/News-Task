//
//  HomeTableViewCell.swift
//  mvvm Demo
//
//  Created by mohsen on 27/12/2022.
//  Copyright © 2022 Pola. All rights reserved.
//

import UIKit
import Kingfisher

class HomeTableViewCell: UITableViewCell {
    
    static let id = "HomeTableViewCell"
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var images: UIImageView!
    
    
    
 

    
    func setUp(NewsList : Articles){
        title.text = NewsList.title
        images.kf.setImage(with:NewsList.urlToImage?.asUrl)
        author.text = NewsList.author ?? "Author"
        
        
        //convert string to date
        let newDateString = NewsList.publishedAt?.convertDateString()
        time.text = newDateString
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        images.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}







 


