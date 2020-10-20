//
//  CustomAlertViewController.swift
//  GHFollowers
//
//  Created by Stefanny Toro Ramirez on 29/07/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import Foundation
import UIKit

class CustomAlertViewController: UIViewController {

    // MARK: - Views
    let titleText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let descriptionText: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let confirmButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Ok", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 5
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(accept), for: .touchUpInside)
        return button
    }()

    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewWillAppear(_ animated: Bool) {
        animate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }

    func setUpViews() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        view.autoresizingMask = [.flexibleHeight,.flexibleWidth]

        containerView.addSubview(titleText)
        containerView.addSubview(descriptionText)
        containerView.addSubview(confirmButton)
        view.addSubview(containerView)

        setContraints()
    }

    private func setContraints() {
        titleText.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        titleText.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true
        titleText.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true


        descriptionText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 15).isActive = true
        descriptionText.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        descriptionText.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        descriptionText.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 15).isActive = true
        descriptionText.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -15).isActive = true
        descriptionText.bottomAnchor.constraint(lessThanOrEqualTo: confirmButton.topAnchor, constant: -8).isActive = true
        descriptionText.setContentCompressionResistancePriority(.defaultLow, for: .vertical)

        confirmButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        confirmButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15).isActive = true
        confirmButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8).isActive = true
        confirmButton.setContentCompressionResistancePriority(.required, for: .vertical)

        containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true

    }

    private func animate() {
        UIView.animate(withDuration: 0.2, delay: 0,
                       usingSpringWithDamping: 0.7, // Damping at the end 0 big spring
            initialSpringVelocity: 1,
            options: .curveEaseInOut,
            animations: { [weak self] in
                self?.containerView.frame.size.width = -(self?.containerView.frame.size.width ?? 1)
                self?.containerView.frame.size.height = -(self?.containerView.frame.size.width ?? 1)
                self?.containerView.layoutIfNeeded()
        })
    }

}

// MARK: - Logic
extension CustomAlertViewController {
    @objc func accept() {
         dismiss(animated: false)
     }

     func set(title: String, desc: String) {
         titleText.text = title
         descriptionText.text = desc
     }
}
