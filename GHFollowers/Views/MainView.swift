//
//  MainView.swift
//  GHFollowers
//
//  Created by Stefanny Toro Ramirez on 23/07/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import UIKit

private struct Constant {
    static let labelHeight: CGFloat = 40
    static let spacing: CGFloat = 30
}

class MainView: UIStackView {

    var logoImage = UIImageView()
    var userName = UITextField()

    var isUserNameEmpty: Bool {
        return userName.text == "" ? true : false
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }

    private func setUpViews() {
        self.axis = .vertical
        self.distribution = .equalSpacing
        self.alignment = .fill
        self.spacing = Constant.spacing

        logoImage.image = UIImage(named: "GFollowers")
        logoImage.contentMode = .scaleAspectFit
        userName.borderStyle = .roundedRect
        userName.placeholder = "Enter Username"
        userName.textAlignment = .center
        userName.keyboardType = .namePhonePad
        userName.autocorrectionType = .no

        userName.delegate = self
        
        self.addArrangedSubview(logoImage)
        self.addArrangedSubview(userName)
        addContraints()
    }

    private func addContraints() {
        userName.heightAnchor.constraint(equalToConstant: Constant.labelHeight).isActive = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}

extension MainView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
