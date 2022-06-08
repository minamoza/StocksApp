//
//  ViewController.swift
//  StocksApp
//
//  Created by Amina Moldamyrza on 25.05.2022.
//

import UIKit

final class StocksViewController: UIViewController{
    
    private let presenter: StocksPresenterProtocol
        
    init(presenter: StocksPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(StockCell.self, forCellReuseIdentifier: StockCell.typeName)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        setupSubviews()
        presenter.loadView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       navigationController?.navigationBar.barStyle = UIBarStyle.default
       navigationController?.navigationBar.tintColor = UIColor.black
   }
    
    private func setupSubviews(){
        view.addSubview(tableView)
        tableView.leadingAnchor.constraint (equalTo: view.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint (equalTo: view.trailingAnchor, constant: -16).isActive = true
        tableView.topAnchor.constraint (equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint (equalTo: view.bottomAnchor).isActive = true
    }
    
}

extension StocksViewController: StocksViewProtocol {
    func updateView() {
        tableView.reloadData()
    }
    
    func updateView(withLoader isLoading: Bool) {
        print("Loader is - ", isLoading, " at ", Date())
    }
    
    func updateView(withError message: String) {
        print("Error - ", message)
    }
}

extension StocksViewController: UITableViewDataSource, UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.itemsCount
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
        
        cell.configure(stock: presenter.model(for: indexPath))
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let network = Network()
        let service = StocksService(client: network)
        let vc = DetailedViewController(presenter: StockPresenter(service: service))
        vc.configure(stock: presenter.model(for: indexPath))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}



