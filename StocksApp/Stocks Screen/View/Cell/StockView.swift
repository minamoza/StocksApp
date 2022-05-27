//
//  StockView.swift
//  StocksApp
//
//  Created by Amina Moldamyrza on 25.05.2022.
//

import UIKit

class StockView: UIView {

    private lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "YNDX"
        label.font = .systemFont(ofSize: 18)
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var subLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Yandex, LLC"
        label.font = .systemFont(ofSize: 12)
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var button: UIButton = {
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "star"), for: .normal)
        btn.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }

    //initWithCode to init view from xib or storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureView(stock: Stock){
        symbolLabel.text = stock.symbol
        subLabel.text = stock.name
    }
    
    private func setupViews(){
        addSubview(symbolLabel)
        addSubview(subLabel)
        addSubview(button)
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        symbolLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        symbolLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        subLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        subLabel.topAnchor.constraint(equalTo: symbolLabel.bottomAnchor).isActive = true
        
        button.leadingAnchor.constraint(equalTo: symbolLabel.trailingAnchor, constant: 6).isActive = true
        button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    @objc func btnTapped(){
        if button.isSelected {
            button.setImage(UIImage(named: "star.colored"), for: .normal)
        } else {
            button.setImage(UIImage(named: "star"), for: .normal)
        }
    }

}
