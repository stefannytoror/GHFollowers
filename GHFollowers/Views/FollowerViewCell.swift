//
//  FollowerViewCell.swift
//  GHFollowers
//
//  Created by Stefanny Toro Ramirez on 31/08/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import UIKit

class FollowerViewCell: UICollectionViewCell {
    // MARK: - Views
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 0
        return stackView
    }()

    var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true // used for corner radius
        image.layer.cornerRadius = 10
        return image
    }()

    var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }

    func setUpViews() {
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(usernameLabel)
        addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            self.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            image.widthAnchor.constraint(equalTo: image.heightAnchor)
        ])
    }

    func configure(imageString: String, label: String) {
        image.setImage(url: imageString)
        usernameLabel.text = label
    }    
}
