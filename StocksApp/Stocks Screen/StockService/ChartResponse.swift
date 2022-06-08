//
//  ChartResponse.swift
//  StocksApp
//
//  Created by Amina Moldamyrza on 08.06.2022.
//

import Foundation

struct Charts: Decodable {
    let prices: [Price]
    
    struct Price: Decodable {
        let date: Date
        let price: Double
        
        init (from decoder: Decoder) throws{
            let container = try decoder.singleValueContainer()
            let array = try container.decode ([Double].self)
            
            guard let time = array[safe: 0],
                  let price = array[safe: 1] else {
                throw NSError()
            }
            
            let date = Date(timeIntervalSince1970: TimeInterval(time/1000))
            
            self.date = date
            self.price = price
        }
    }
}
