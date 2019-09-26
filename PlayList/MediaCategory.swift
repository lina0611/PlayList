//
//  MediaCategory.swift
//  PlayList
//
//  Created by Lina Gao on 9/26/19.
//  Copyright © 2019 Lina Gao. All rights reserved.
//

import Foundation
import UIKit

enum MediaType: String {
    case music = "Music"
    case movie = "Movie"
}

class MediaCategory {

    var mediaList = [Media]()
    var mediaType: MediaType

    init(mediaType: MediaType, mediaList: [Media]) {
        self.mediaList = mediaList
        self.mediaType = mediaType
    }
}
