//
//  NSObjectExtension.swift
//  StocksApp
//
//  Created by Amina Moldamyrza on 08.06.2022.
//

import Foundation

extension NSObject {
    static var typeName: String {
        String(describing: self)
    }
}
