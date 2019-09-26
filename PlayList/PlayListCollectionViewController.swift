//
//  PlayListCollectionViewController.swift
//  PlayList
//
//  Created by Lina Gao on 9/26/19.
//  Copyright © 2019 Lina Gao. All rights reserved.
//

import UIKit

class PlayListCollectionViewController: UICollectionViewController {

    private enum Constants {
        static let cellIdentifier = "CategoryCell"
        static let failToGetCell = "Failed to dequeue CategoryCell"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = UIColor.white

        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? CategoryCell else {
            preconditionFailure(Constants.failToGetCell)
        }
        return cell
    }
}

