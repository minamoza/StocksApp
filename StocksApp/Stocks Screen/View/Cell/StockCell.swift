//
//  StockCell.swift
//  StocksApp
//
//  Created by Amina Moldamyrza on 25.05.2022.
//

import Foundation
import UIKit

final class StockCell: UITableViewCell {
    
    private lazy var iconView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var deltaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 36/255, green: 178/255, blue: 93/255, alpha: 1)
        label.font = .systemFont(ofSize: 12)
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var view = StockView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width/2, height: contentView.frame.height - 4))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init (style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
    }

    required init? (coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(stock: StockModelProtocol){
    
        priceLabel.text = stock.price
        deltaLabel.text = stock.change
        
        if let imageURL = URL(string: stock.iconURL){
           iconView.load(url: imageURL)
       }
        
//      дальше передаем данные чтобы взять stock.name и stock.symbol
        view.configureView(stock: stock)
    }
    
    private func setupViews(){
        contentView.addSubview(iconView)
        contentView.addSubview(view)
        contentView.addSubview(priceLabel)
        contentView.addSubview(deltaLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 52).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 52).isActive = true
        
        view.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12).isActive = true
        view.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14).isActive = true
        
        priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17).isActive = true
        priceLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14).isActive = true
        
        deltaLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17).isActive = true
        deltaLabel.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 14).isActive = true
    }
}



