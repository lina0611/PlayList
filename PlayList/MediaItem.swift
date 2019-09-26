//
//  MediaItem.swift
//  PlayList
//
//  Created by Lina Gao on 9/26/19.
//  Copyright © 2019 Lina Gao. All rights reserved.
//

import Foundation
import UIKit

enum MediaType: String, CustomStringConvertible {
    case music = "Music"
    case movie = "Movie"
    case tvShow = "TV Shows"

    var description: String {
        switch self {
        case .music:
            return "apple-music/top-albums"
        case .movie:
            return "movies/top-movies"
        case .tvShow:
            return "tv-shows/top-tv-episodes"
        }
    }
}

struct MediaItem {
    var albumName: String
    var image: UIImage
    var mediaType: MediaType
}
