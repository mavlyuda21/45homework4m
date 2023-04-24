//
//  MainView.swift
//  45homework4m
//
//  Created by mavluda on 24/4/23.
//

import UIKit
import Foundation
import SnapKit

class MainView: UIViewController{
    private var controller: MainController?
    
    private lazy var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero,
                                     collectionViewLayout: layout)
        view.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseId)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = .cyan
        return view
    }()
    
    private lazy var searchBar = UISearchBar()
    
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller = MainController(view: self)
        view.backgroundColor = .cyan
        controller?.downloadProducts()
        setupSubviews()
    }
    
    func setupSubviews(){
        searchBar.placeholder = "Search for item"
        navigationItem.titleView = searchBar
        searchBar.delegate = self
        view.addSubview(productsCollectionView)
        productsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview().inset(5)
            make.bottom.equalToSuperview()
        }
    }
    
    func reloadCollection(){
        DispatchQueue.main.async {
            self.productsCollectionView.reloadData()
        }
    }
}

extension MainView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searching == false{
            return (controller?.getProducts().count)!
        }else{
            return (controller?.getFilteredCount())!
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseId, for: indexPath) as! ProductCell
        cell.makeDelegate(view: self)
        if searching == false{
            cell.fill(product: (controller?.getProducts()[indexPath.row])!, indexPath: indexPath)
        }else{
            cell.fill(product: (controller?.getFiltered()[indexPath.row])!, indexPath: indexPath)
        }
        return cell
    }
    
    
}

extension MainView: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 20, height: 280)
    }
}

extension MainView: HeartTapDelegate{
    func heartTappedAtIndex(index: IndexPath) {
        controller?.heartTapped(index: index)
    }
}

extension MainView: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.isEmpty == false{
            searching = true
            controller?.textChange(searchBar.text ?? "")
        }else{
            searching = false
            reloadCollection()
        }
    }
}
