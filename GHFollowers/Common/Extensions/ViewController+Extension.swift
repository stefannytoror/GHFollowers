//
//  ViewController+Extension.swift
//  GHFollowers
//
//  Created by Stefanny Toro Ramirez on 3/08/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func dismissKeyBoardIfExists() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tap.cancelsTouchesInView = false // Avoid conflicts with table and collection views
        view.addGestureRecognizer(tap)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
