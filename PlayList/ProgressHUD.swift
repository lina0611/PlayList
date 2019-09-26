//
//  ProgressHUD.swift
//  PlayList
//
//  Created by Lina Gao on 9/26/19.
//  Copyright © 2019 Lina Gao. All rights reserved.
//

import Foundation
import UIKit

private enum Constants {
    static let indicatorText = "Loading"
}

class ProgressHUD: UIView {

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = UIActivityIndicatorView.Style.medium
        return indicator
    }()

    private let label: UILabel = {
        let textLabel = UILabel()
        textLabel.text = Constants.indicatorText
        textLabel.textColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        return textLabel
    }()

    private let backView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.clear
        backgroundView.alpha = 0.2
        backgroundView.layer.cornerRadius = 8.0
        backgroundView.clipsToBounds = true
        return backgroundView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        if let superview = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 0.5).isActive = true
            self.heightAnchor.constraint(equalToConstant: 80).isActive = true
            self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
            self.centerYAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.centerYAnchor).isActive = true

            // ActivityIndicator
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            activityIndicator.widthAnchor.constraint(equalToConstant: 44).isActive = true
            activityIndicator.widthAnchor.constraint(equalTo: activityIndicator.heightAnchor, multiplier: 1).isActive = true
            activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            activityIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true

            // Label
            label.translatesAutoresizingMaskIntoConstraints = false
            label.heightAnchor.constraint(equalTo: activityIndicator.heightAnchor).isActive = true
            label.leadingAnchor.constraint(equalTo: activityIndicator.trailingAnchor, constant: 5).isActive = true
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            label.centerYAnchor.constraint(equalTo: activityIndicator.centerYAnchor).isActive = true

            // BackView
            backView.translatesAutoresizingMaskIntoConstraints = false
            backView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
            backView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            backView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            backView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        }
    }

    private func setup() {
        self.addSubview(backView)
        self.addSubview(activityIndicator)
        self.addSubview(label)
        activityIndicator.startAnimating()
    }
}
