//
//  HeadlineCell.swift
//  NewTask
//
//  Created by mohsen on 28/12/2022.
//

import UIKit

class HeadlineCell: UICollectionViewCell {
    
    static let id = "HeadlineCell"
    
    @IBOutlet weak var images: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var author: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    
    func setup(HeadlineList : Articles){
        title.text = HeadlineList.title
        images.kf.setImage(with:HeadlineList.urlToImage?.asUrl)
        author.text = HeadlineList.author ?? "Author"
        
        
        // convert string to date
        let newDateString = HeadlineList.publishedAt?.convertDateString()
        time.text = newDateString
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        images.layer.cornerRadius = 10
        // Initialization code
    }

}
