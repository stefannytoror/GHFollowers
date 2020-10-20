//
//  EmptyStateView.swift
//  GHFollowers
//
//  Created by Stefanny Toro Ramirez on 25/09/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import Foundation
import UIKit

class EmptyStateView: UIView {

    var message: UILabel = {
        var message = UILabel()
        message.translatesAutoresizingMaskIntoConstraints = false
        message.textColor = .lightGray
        message.font =  .boldSystemFont(ofSize: 24)
        message.numberOfLines = 0
        message.textAlignment = .center
        message.text = "This user doesn't have any followers 😞."
        return message
    }()

    var image: UIImageView = {
        var image = UIImageView(image: UIImage(named: "GEmptyState"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        //image.clipsToBounds = true  --> Cut the image
        return image
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }


    func setUpView() {
        self.addSubview(message)
        self.addSubview(image)

        NSLayoutConstraint.activate([
            message.bottomAnchor.constraint(equalTo: image.topAnchor),
            message.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            message.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
        ])

        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.7),
            image.widthAnchor.constraint(equalTo: image.heightAnchor),
            image.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 100),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: self.frame.width / 4),
        ])
    }



}
