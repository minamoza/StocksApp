//
//  DetailedViewController.swift
//  StocksApp
//
//  Created by Amina Moldamyrza on 27.05.2022.
//

import UIKit

class DetailedViewController: UIViewController {
    
    private let presenter: StockChartPresenterProtocol
    private var charts: Charts = Charts(prices: [])
    
    init(presenter: StockChartPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32)
        label.font = .boldSystemFont(ofSize: 32)
        return label
    }()
    
    private lazy var persentageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 36/255, green: 178/255, blue: 93/255, alpha: 1)
        label.font = .systemFont(ofSize: 16)
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var graphView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.4))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var periodCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(PeriodCell.self, forCellWithReuseIdentifier: "cell")
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    private lazy var buyButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Buy for $132.4", for: .normal)
        btn.backgroundColor = UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1)
        btn.layer.cornerRadius = 16
        return btn
    }()
    
    private var periods: [String] = ["D", "W", "M", "6M", "1Y", "All"]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        self.tabBarController?.tabBar.isHidden = true
        
        periodCollectionView.delegate = self
        periodCollectionView.dataSource = self
        
        setupViews()
    }

    
    func configure(stock: StockModelProtocol){
        setupNavBar(title: stock.symbol, subtitle: stock.name)
        presenter.getStockChart(id: stock.id)
        priceLabel.text = stock.price
        persentageLabel.text = stock.change
    }
    
    private func setupViews(){
        view.addSubview(priceLabel)
        view.addSubview(persentageLabel)
        view.addSubview(graphView)
        view.addSubview(buyButton)
        view.addSubview(periodCollectionView)
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        
        priceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        priceLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.18).isActive = true
        
        persentageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        persentageLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 3).isActive = true
    
        graphView.topAnchor.constraint(equalTo: persentageLabel.bottomAnchor, constant: 20).isActive = true
        graphView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        graphView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        graphView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.5).isActive = true
        
        periodCollectionView.topAnchor.constraint(equalTo: graphView.bottomAnchor, constant: 20).isActive = true
        periodCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        periodCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        periodCollectionView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        buyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
        buyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        buyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        buyButton.heightAnchor.constraint(equalToConstant: 56).isActive = true
    }
    
    private func setupNavBar(title: String, subtitle: String){
        navigationItem.setTitle(title: title, subtitle: subtitle)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "star"), style:.plain, target: self, action: nil)
    }

}

extension DetailedViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return periods.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PeriodCell
        
        cell.configure(period: periods[indexPath.row])
        return cell
    }
}

extension DetailedViewController:UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.14, height: collectionView.frame.height)
    }
}

//добавляем title и subtitle в navigationItem
extension UINavigationItem {
    func setTitle(title:String, subtitle:String) {
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 17)
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.sizeToFit()
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.textAlignment = .center
        subtitleLabel.sizeToFit()
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stackView.distribution = .equalCentering
        stackView.axis = .vertical
        stackView.alignment = .center
        
        let width = max(titleLabel.frame.size.width, subtitleLabel.frame.size.width)
        stackView.frame = CGRect(x: 0, y: 0, width: width, height: 35)
        
        titleLabel.sizeToFit()
        subtitleLabel.sizeToFit()
        
        self.titleView = stackView
    }
}

