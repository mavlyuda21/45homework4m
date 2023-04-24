//
//  ProductCell.swift
//  45homework4m
//
//  Created by mavluda on 24/4/23.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

protocol HeartTapDelegate: AnyObject{
    func heartTappedAtIndex(index: IndexPath)
}

class ProductCell: UICollectionViewCell {
    static var reuseId = "product_cell"
    
    weak var delegate: HeartTapDelegate? = nil
    
    private lazy var productImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var productTitleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private var favorited = false
    
    var index: IndexPath? = nil
    
    private lazy var favoriteButton: UIButton = {
        let view = UIButton()
        view.tintColor = .red
        view.addTarget(self, action: #selector(makeFavorite(button:)), for: .touchUpInside)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 5
        backgroundColor = .white
    }
    
    func makeDelegate(view: HeartTapDelegate){
        self.delegate = view
    }
    
    required init? (coder: NSCoder) {
        fatalError()
    }
    
    private func setupSubviews () {
        addSubview (productImageView)
        productImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        addSubview(productTitleLabel)
        productTitleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(5)
            make.top.equalTo(productImageView.snp.bottom).offset(10)
        }
        
        addSubview(productPriceLabel)
        productPriceLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.top.equalTo(productTitleLabel.snp.bottom).offset(10)
        }
        
        addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { make in
            make.width.height.equalTo(25)
            make.top.equalTo(productTitleLabel.snp.bottom)
            make.right.equalToSuperview().inset(10)
        }
        checkImage()
    }
    
    private func checkImage(){
        switch favorited{
        case true: favoriteButton.setImage(UIImage(systemName: "heart.fill"),for: .normal)
        case false: favoriteButton.setImage(UIImage(systemName: "heart"),for: .normal)
        }
    }
    
    @objc func makeFavorite(button: UIButton){
        switch favorited{
        case false:
            favorited = true
            delegate?.heartTappedAtIndex(index: index!)
            checkImage()
        case true:
            return
        }
    }
    
    func fill(product: Product, indexPath: IndexPath){
        self.productImageView.kf.setImage(with: URL(string: product.thumbnail))
        self.productTitleLabel.text = product.title
        self.productPriceLabel.text = String(product.price) + "$"
        self.index = indexPath
    }
    
    func makeHeartInvisible(){
        self.favoriteButton.isHidden = true
    }
}

