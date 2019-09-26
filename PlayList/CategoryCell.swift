//
//  CategoryCell.swift
//  PlayList
//
//  Created by Lina Gao on 9/26/19.
//  Copyright © 2019 Lina Gao. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    var mediaCategory: MediaCategory? {
        didSet {
            if let mediaCategory = mediaCategory {
                mediaTypeLabel.text = mediaCategory.mediaType.rawValue
            }
        }
    }

    private let cellIdentifier = "MediaItemCell"

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let mediaTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let mediaItemscollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    let dividerLineView: UIView = {
        let dividerLineView = UIView()
        dividerLineView.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        dividerLineView.translatesAutoresizingMaskIntoConstraints = false
        return dividerLineView
    }()

    private func setupViews() {
        backgroundColor = UIColor.clear

        addSubview(mediaItemscollectionView)
        addSubview(dividerLineView)
        addSubview(mediaTypeLabel)

        mediaItemscollectionView.dataSource = self
        mediaItemscollectionView.delegate = self

        mediaItemscollectionView.register(MediaItemCell.self, forCellWithReuseIdentifier: cellIdentifier)

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": mediaTypeLabel]))

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": dividerLineView]))

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": mediaItemscollectionView]))

        NSLayoutConstraint.activate(NSLayoutConstraint.constraints(withVisualFormat: "V:|[mediaTypeLabel(40)][v0][v1(0.5)]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": mediaItemscollectionView, "v1": dividerLineView, "mediaTypeLabel": mediaTypeLabel]))
    }
}

extension CategoryCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let mediaCategory = mediaCategory else {
            return 0
        }
        return mediaCategory.mediaList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)as? MediaItemCell else {
            preconditionFailure("Failed to deque MediaItemCell")
        }
        if let mediaCategory = mediaCategory {
            cell.configure(with: mediaCategory.mediaList[indexPath.row], mediaType: mediaCategory.mediaType)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: frame.height - 40)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}
