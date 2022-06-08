//
//  StockPresenter.swift
//  StocksApp
//
//  Created by Amina Moldamyrza on 01.06.2022.
//

import Foundation

protocol StockChartPresenterProtocol {
//    var chart: Charts { get }

    func getStockChart(id: String)
}

final class StockPresenter: StockChartPresenterProtocol{
    
//    var chart: Charts
    
    private let service: StocksServiceProtocol

    internal init(service: StocksServiceProtocol) {
        self.service = service
    }
    
    func getStockChart(id: String) {
        
        service.getStockChart(id: id, carrency: "usd", days: "60", isDaily: false) { [weak self] result in
            switch result{
            case .success(let chart):
                print(chart.prices)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}

