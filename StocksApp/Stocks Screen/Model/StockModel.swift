//
//  StockModel.swift
//  StocksApp
//
//  Created by Amina Moldamyrza on 28.05.2022.
//

import Foundation
import UIKit

protocol StockModelProtocol {
    var id: String { get }
    var name: String { get }
    var iconURL: String { get }
    var symbol: String { get }
    var price: String { get }
    var change: String { get }
    var changeColor: UIColor { get }
    
    var isFavorite: Bool { get set }
}

final class StockModel: StockModelProtocol {
    
    private let stock: Stock

    init(stock: Stock) {
        self.stock = stock
    }
    
    var id: String {
        stock.id
    }
    
    var name: String {
        stock.name
    }
    
    var iconURL: String {
        stock.image
    }
    
    var symbol: String {
        stock.symbol
    }
    
    var price: String {
        let price = roundValues(value: stock.price, numberOfPlaces: 2)
        
        return "\(price)"
    }
    
    var change: String {
        let change = roundValues(value: stock.change, numberOfPlaces: 2)
        let persentage = roundValues(value: stock.changePercentage, numberOfPlaces: 2)
        
        return "\(change) $ (\(persentage)%)"
    }
    
    var changeColor: UIColor {
        stock.change >= 0 ? .green : .red
    }
    
    var isFavorite: Bool = false
    
    //    округляет данные(использована рекурсия)
   func roundValues(value: Double, numberOfPlaces: Double) -> String{
        let multiplier = pow(10.0, numberOfPlaces)
        let rounded = round(value * multiplier) / multiplier
        
        if abs(rounded) > 0{
            return rounded.formatted(with: " ", style: .decimal, locale: .frenchFR)
        }
        
        return roundValues(value: value, numberOfPlaces: numberOfPlaces + 1)
    }
}
