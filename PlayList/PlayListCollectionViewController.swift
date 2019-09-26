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

    private var dataManager = DataManager()
    private var medias = [MediaCategory]()

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
        fetchData()
    }

    private func fetchData() {
        dataManager.fetchAll { [weak self] mediaList in
            guard let self = self else { return }
                if let mediaList = mediaList {
                    self.medias = mediaList
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medias.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? CategoryCell else {
            preconditionFailure(Constants.failToGetCell)
        }

        cell.mediaCategory = medias[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 220)
    }
}

