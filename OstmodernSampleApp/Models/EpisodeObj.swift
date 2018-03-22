//
//  Episode.swift
//  Ostmodern Sample App
//
//  Created by Felix Fischer on 22.03.18.
//  Copyright © 2018 Felix Fischer. All rights reserved.
//

import Foundation

class EpisodeObj: Codable {
    
    let title: String
    let synopsis: String
    let image: String
    let imageType: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case synopsis
        case image
        case imageType = "image-type"
    }
}


