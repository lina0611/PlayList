//
//  PlayListCollectionViewController.swift
//  PlayList
//
//  Created by Lina Gao on 9/26/19.
//  Copyright © 2019 Lina Gao. All rights reserved.
//

import UIKit

class PlayListCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private enum Constants {
        static let cellIdentifier = "CategoryCell"
        static let failToGetCell = "Failed to dequeue CategoryCell"
        static let largeTitle = "PlayList"
    }

    /// Setup large navigation title
    private func configureNavigationBar() {
        navigationItem.title = Constants.largeTitle
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar()
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 220)
    }
}

