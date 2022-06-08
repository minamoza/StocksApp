//
//  PeriodCell.swift
//  StocksApp
//
//  Created by Amina Moldamyrza on 27.05.2022.
//

import UIKit

class PeriodCell: UICollectionViewCell {
    
    private let blackColor = UIColor(red: 26/255, green: 26/255, blue: 26/255, alpha: 1)
    private let grayColor = UIColor(red: 240/255, green: 244/255, blue: 247/255, alpha: 1)
    
    private lazy var periodLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 12)
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = grayColor
        self.layer.cornerRadius = 12
        
        setupViews()
    }
    
    override var isSelected: Bool {
        didSet {
            self.contentView.backgroundColor = isSelected ? blackColor : grayColor
            periodLabel.textColor = isSelected ? .white : .black
            self.contentView.layer.cornerRadius = 12
        }
    }

    required init? (coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(period: String){
        periodLabel.text = period
    }
    
    private func setupViews(){
        contentView.addSubview(periodLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints(){
        periodLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        periodLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
}
