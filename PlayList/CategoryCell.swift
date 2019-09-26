//
//  CategoryCell.swift
//  PlayList
//
//  Created by Lina Gao on 9/26/19.
//  Copyright © 2019 Lina Gao. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    

    func setupViews() {
        backgroundColor = UIColor.black
    }
}
