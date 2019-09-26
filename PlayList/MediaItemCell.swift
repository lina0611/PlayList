//
//  MediaItemCell.swift
//  PlayList
//
//  Created by Lina Gao on 9/26/19.
//  Copyright © 2019 Lina Gao. All rights reserved.
//

import UIKit

class MediaItemCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.yellow
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true

        return imageView
    }()

    let albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Love you so much"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()

    let mediaTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Music"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.darkGray
        return label
    }()

    func configure(with media: Media) {
        albumNameLabel.text = media.albumName
        imageView.image = media.image
    }

    private func setupViews() {
        addSubview(imageView)
        addSubview(albumNameLabel)
        addSubview(mediaTypeLabel)
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        albumNameLabel.frame = CGRect(x: 0, y: frame.width + 2, width: frame.width, height: 40)
        mediaTypeLabel.frame = CGRect(x: 0, y: frame.width + 42, width: frame.width, height: 20)
    }
}
