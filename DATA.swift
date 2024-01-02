//
//  DATA.swift
//  yuna_endproject
//
//  Created by user05 on 2023/12/10.
//

import Foundation

struct Bandori_card: Codable {
    
    var title: String
    var image_url:URL
    var url:URL
    var synopsis:String
    var type:String
    var episodes:Int
    //var score:Int
    
    
 
}

struct Bandori_cardResults: Codable {

 var results: [Bandori_card]
}
