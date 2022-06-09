//
//  FavoriteView.swift
//  45homework4m
//
//  Created by mavluda on 24/4/23.
//

import Foundation
import UIKit

class FavoriteView: UIViewController{
    private var controller: FavoriteController?
    
    private lazy var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView( frame: .zero,
                                     collectionViewLayout: layout)
        view.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseId)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .cyan
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = FavoriteController(view: self)
        view.backgroundColor = .cyan
        setupSubviews()
        controller?.checkFavorites()
        reloadCollection()
    }
    
    func setupSubviews(){
        view.addSubview(productsCollectionView)
        productsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(5)
            make.bottom.equalToSuperview()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadCollection()
    }
    
    func reloadCollection(){
        DispatchQueue.main.async {
            self.productsCollectionView.reloadData()
        }
    }
}

extension FavoriteView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return controller!.getCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell
        cell.fill(product: controller!.getFavorite(index: indexPath.row), indexPath: indexPath)
        return cell
    }
    
    
}

extension FavoriteView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 20, height: 280)
    }
}
