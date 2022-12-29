//
//  NewsModel.swift
//  mvvm Demo
//
//  Created by mohsen on 27/12/2022.
//  Copyright © 2022 Pola. All rights reserved.
//

import Foundation


//struct NewsModel : Codable{
//   let Image : String?
//   let Title : String?
//   let Time : String?
//   let Author : String?
//}




struct NewsModel : Codable {
    let status : String?
    let totalResults : Int?
    let articles : [Articles]?
}


 
struct Articles : Codable {
    let source : Source?
    let author : String?
    let title : String?
    let description : String?
    let url : String?
    let urlToImage : String?
    let publishedAt : String?
    let content : String?
 
}


struct Source : Codable {
    let id : String?
    let name : String?

}
