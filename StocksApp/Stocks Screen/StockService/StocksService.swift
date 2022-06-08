//
//  StocksService.swift
//  StocksApp
//
//  Created by Amina Moldamyrza on 27.05.2022.
//

import Foundation


protocol StocksServiceProtocol{
    func getStocks (carrency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void)
    func getStocks (carrency: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void)
    func getStocks (completion: @escaping (Result<[Stock], NetworkError>) -> Void)
    func getStockChart (id: String, carrency: String, days: String, isDaily: Bool, completion: @escaping (Result<Charts, NetworkError>) -> Void)
}

extension StocksServiceProtocol {
    func getStocks(carrency: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        getStocks(carrency: carrency, count: "100", completion: completion)
    }
    func getStocks(completion: @escaping (Result<[Stock], NetworkError>) -> Void) {
        getStocks(carrency: "usd", completion: completion)
    }
}

final class StocksService: StocksServiceProtocol {
    

    private let client: NetworkService
    
    init(client: NetworkService) {
        self.client = client
    }
    
    func getStocks (carrency: String, count: String, completion: @escaping (Result<[Stock], NetworkError>) -> Void){
        client.execute(with: StocksRouter.stocks (carrency: carrency, count: count), completion: completion)
    }
    
    func getStockChart(id: String, carrency: String, days: String, isDaily: Bool, completion: @escaping (Result<Charts, NetworkError>) -> Void) {
        client.execute(with: StocksRouter.stock(id: id, currency: carrency, days: days, isDaily: isDaily), completion: completion)
    }
}

