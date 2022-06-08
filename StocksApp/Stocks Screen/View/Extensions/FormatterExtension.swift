//
//  FormatterExtension.swift
//  StocksApp
//
//  Created by Amina Moldamyrza on 27.05.2022.
//

import Foundation

extension Formatter {
    static let number = NumberFormatter()
}

extension Locale {
    static let englishUS: Locale = .init(identifier: "en_US")
    static let frenchFR: Locale = .init(identifier: "fr_FR")
    static let portugueseBR: Locale = .init(identifier: "pt_BR")
}

extension Numeric {
    func formatted(with groupingSeparator: String? = nil, style: NumberFormatter.Style, locale: Locale = .englishUS) -> String {
        Formatter.number.locale = locale
        Formatter.number.numberStyle = style
        
        if let groupingSeparator = groupingSeparator {
            Formatter.number.groupingSeparator = groupingSeparator
        }

        return Formatter.number.string(for: self) ?? ""
    }
}
