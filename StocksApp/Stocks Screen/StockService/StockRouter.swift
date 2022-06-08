//
//  StockRouter.swift
//  StocksApp
//
//  Created by Amina Moldamyrza on 28.05.2022.
//

import Foundation

enum StocksRouter: Router {
    case stocks (carrency: String, count: String)
    case stock (id: String, currency: String, days: String, isDaily: Bool)
    
    var baseUrl: String {
        "https://api.coingecko.com"
    }
    
//https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=100
//https://api.coingecko.com/api/v3/coins/%5BID%5D/market_chart?vs_currency=usd&days=600&interval=daily
    
    var path: String{
        switch self{
        case .stocks:
            return "/api/v3/coins/markets"
        case .stock(let id,_,_,_):
            return "/api/v3/coins/\(id)/market_chart"
            
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .stocks:
            return .get
        case .stock:
            return .get
        }
    }
        
    var parameters: Parameters {
        switch self{
        case .stocks(let carrency, let count) :
            return ["vs_currency": carrency, "per_page": count]
        case .stock(_, let carrency, let days, let isDaily):
            return ["vs_currency": carrency, "days": days, "interval": isDaily ? "daily" : ""]
        }
    }
}

