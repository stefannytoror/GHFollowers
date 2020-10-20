//
//  UIImage+Extension.swift
//  GHFollowers
//
//  Created by Stefanny Toro Ramirez on 7/08/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setImage(url: String) {
        //set default Image
//        self.image = UIImage(named: "GFollowers")

        ServiceManager.requestImage(url: url) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            case .failure(_ ):
                break
            }
        }
    }
}
