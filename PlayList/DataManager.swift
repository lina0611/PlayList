//
//  DataManager.swift
//  PlayList
//
//  Created by Lina Gao on 9/26/19.
//  Copyright © 2019 Lina Gao. All rights reserved.
//

import Foundation
import UIKit

class DataManager {

    private enum Constants {
        static let musicURL = "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.json"
        static let movieURL = "https://rss.itunes.apple.com/api/v1/us/movies/top-movies/all/10/explicit.json"
        static let feedKey = "feed"
        static let resultsKey = "results"
        static let artworkUrlKey = "artworkUrl100"
    }

    /// Load All medias data from server
    ///
    /// - Parameter completionBlock: return an array of MediaCategory
    func fetchAll(completion: @escaping (_ medias: [MediaCategory]?) -> Void) {
        var mediaCollector = [MediaCategory]()
        loadMusics { [weak self] musics in
            guard let self = self else { return }
            if let musics = musics {
                mediaCollector.append(MediaCategory(mediaType: .music, mediaList: musics))
            }
            self.loadMovies { movies in
                if let movies = movies {
                    mediaCollector.append(MediaCategory(mediaType: .movie, mediaList: movies))
                }
                completion(mediaCollector)
            }
        }
    }

    /// Load Movies from server
    ///
    /// - Parameter completionBlock: return an array of Media
    private func loadMovies(completionBlock: @escaping (_ medias: [Media]?) -> Void) {
        guard let url = URL(string: Constants.movieURL) else { return }
        loadMediaFromServerwith(url) { movies in
            completionBlock(movies)
        }
    }

    /// Load Musics from server
    ///
    /// - Parameter completionBlock: Return an array of Media
    private func loadMusics(completionBlock: @escaping (_ medias: [Media]?) -> Void) {
        guard let url = URL(string: Constants.musicURL) else { return }
        loadMediaFromServerwith(url) { musics in
            completionBlock(musics)
        }
    }

    /// load Media Data From Server
    ///
    /// - Parameters:
    ///   - url: Target URL
    ///   - completionBlock: Return an array of Media
    private func loadMediaFromServerwith(_ url: URL, completionBlock: @escaping (_ medias: [Media]?) -> Void) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if error != nil {
                completionBlock(nil)
            }

            guard let data = data else { return }

            do {
                let rawJson = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]

                guard let feedDic = rawJson[Constants.feedKey] as? [String: Any] else {
                    preconditionFailure("Unable to get feed data")
                }

                guard let resultDic = feedDic[Constants.resultsKey] as? [[String: Any]] else {
                    preconditionFailure("Unbale to get results data")
                }

                var mediaCollector = [Media]()
                let dispatchGroup = DispatchGroup()

                for resultItem in resultDic {
                    dispatchGroup.enter()
                    let media = Media(with: resultItem)
                    let artworkUrl = resultItem[Constants.artworkUrlKey] as? String ?? ""
                    // Download image
                    self.downloadImageFromUrl(imageString: artworkUrl) { image in
                        media.image = image
                        dispatchGroup.leave()
                    }
                    mediaCollector.append(media)
                }

                dispatchGroup.notify(queue: DispatchQueue.main, execute: {
                    completionBlock(mediaCollector)
                })
            } catch {
                completionBlock(nil)
            }
        }.resume()
    }

    /// Download Image from Json
    ///
    /// - Parameters:
    ///   - imageString: Target Image String
    ///   - completionBlock: Return an UIImage
    private func downloadImageFromUrl(imageString: String, completionBlock: @escaping (_ image: UIImage?) -> Void) {
        let url = URL(string: imageString)
        do {
            let data = try Data(contentsOf: url!)
            completionBlock(UIImage(data: data))
        } catch {
            completionBlock(nil)
        }
    }
}
