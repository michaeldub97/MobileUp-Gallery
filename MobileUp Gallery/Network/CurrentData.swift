//
//  CurrentData.swift
//  MobileUp Gallery
//
//  Created by Михаил on 28.03.2022.
//

import Foundation

struct DataResponce : Decodable {
    let response: CurrentData
}

struct CurrentData : Decodable {
    let count: Int
    let items: [Information]
}

struct Information: Decodable {
    
    struct Size : Decodable {
        let url : String
        let type : String
    }
    
    let date: Int
    let sizes: [Size]
    
    var previewImageUrl: URL? {
        guard let urlString = sizes.first(where: { $0.type == "r" })?.url else { return nil }
        return URL(string: urlString)
    }
    
    var detailImageUrl: URL? {
        guard let urlString = sizes.first(where: { $0.type == "y" })?.url else { return nil }
        return URL(string: urlString)
    }
}
