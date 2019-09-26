//
//  Media.swift
//  PlayList
//
//  Created by Lina Gao on 9/26/19.
//  Copyright © 2019 Lina Gao. All rights reserved.
//

import Foundation
import UIKit

class Media {

    static let albumNameKey = "name"

    var albumName: String
    var image: UIImage?
    var mediaType: MediaType?

    init(with mediaDic: [String: Any]) {
        albumName = mediaDic[Media.albumNameKey] as? String ?? ""
    }
}
