//
//  ImageViewExtension.swift
//  StocksApp
//
//  Created by Amina Moldamyrza on 27.05.2022.
//

import Foundation
import UIKit

//загружает картинки
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

