//
//  ViewController.swift
//  StocksApp
//
//  Created by Amina Moldamyrza on 25.05.2022.
//

import UIKit

final class StocksViewController: UIViewController {
    
    private var stocks: [Stock] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupSubviews()
        getStocks()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupSubviews(){
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint (equalTo: view.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint (equalTo: view.trailingAnchor, constant: -16).isActive = true
        tableView.topAnchor.constraint (equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint (equalTo: view.bottomAnchor).isActive = true
    }
    
    private func getStocks(){
        let session = URLSession(configuration: .default)
        let urlString = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=100"
        guard let url = URL(string: urlString) else {return}
        
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error - ", error)
            }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            print("Status code - ", response.statusCode)
            
            guard let data = data else {
                return
            }
            
            guard let json = try? JSONDecoder().decode([Stock].self, from: data) else{
                return
            }
        
            DispatchQueue.main.async{
                self.stocks = json
                self.tableView.reloadData()
            }
        }
        
        task.resume()
    }


}

extension StocksViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return stocks.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StockCell.typeName, for: indexPath) as! StockCell
        
        if indexPath.section % 2 == 0{
            cell.backgroundColor = UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
            cell.layer.cornerRadius = 16
        }
        
        cell.configure(stock: stocks[indexPath.section])
            
        return cell
    }
    
    
}

extension NSObject {
    static var typeName: String {
        String(describing: self)
    }
}

