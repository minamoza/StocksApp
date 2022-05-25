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
        image.image = UIImage(named: "YNDX")
        return image
    }()
    
    private lazy var price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "4 764,6 ₽"
        label.font = .systemFont(ofSize: 18)
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var delta: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+55 ₽ (1,15%)"
        label.textColor = UIColor(red: 36/255, green: 178/255, blue: 93/255, alpha: 1)
        label.font = .systemFont(ofSize: 12)
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    private lazy var view = StockView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width/2, height: 40))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init (style: style, reuseIdentifier: reuseIdentifier)

        view.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }

    required init? (coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        contentView.addSubview(iconView)
        contentView.addSubview(view)
        contentView.addSubview(price)
        contentView.addSubview(delta)
        
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
        
        price.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17).isActive = true
        price.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 14).isActive = true
        
        delta.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -17).isActive = true
        delta.bottomAnchor.constraint(equalTo: price.bottomAnchor, constant: 14).isActive = true
    }
}
