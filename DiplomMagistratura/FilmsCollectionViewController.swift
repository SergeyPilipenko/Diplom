//
//  FilmsCollectionViewController.swift
//  DiplomMagistratura
//
//  Created by Admin on 18.03.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import UIKit


class FilmsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    // MARK: --Variables
    let cellId = "Cell"
    let filterLauncher = Filterlauncher()
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        return mb
    }()
    
    lazy var filterBarButtonItem: UIBarButtonItem = {
        let filterImage = UIImage(named: "navi_back_btn")
        let filterBarButtonItem = UIBarButtonItem(image: filterImage, style: .plain, target: self, action: #selector(handleFilter))
        return filterBarButtonItem
    }()
    
    lazy var fixedItem: UIBarButtonItem = {
       let fi = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        return fi
    }()
    
    // MARK: --Support functions
    func setupCollectionView(){
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        self.collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        self.collectionView?.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        self.collectionView?.isPagingEnabled = true
        self.collectionView?.showsHorizontalScrollIndicator = false
        self.collectionView?.bounces = false
    }
    
    func setupNavigationBar(){
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItems = [fixedItem, filterBarButtonItem, fixedItem]
    }
    
    func setupMenuBar(){
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        view.addSubview(whiteView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: whiteView)
        view.addConstraintsWithFormat(format: "V:[v0(44)]", views: whiteView)
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(44)]", views: menuBar)
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    func setupSearchBar() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск фильмов"
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        self.navigationItem.titleView = searchBar
    }
    
    func scrollToMenuIndex(index: Int){
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    // MARK: Selectors
    func handleFilter() {
        filterLauncher.showLauncher()
    }
    
    // MARK: View functions
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
        setupSearchBar()
        setupMenuBar()
        setupNavigationBar()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: SearchBar functions
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        
        navigationItem.setRightBarButtonItems([], animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
        navigationItem.setRightBarButtonItems([fixedItem, filterBarButtonItem], animated: true)
    }
    
    

    // MARK: CollectionView functions
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        cell.homeController = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 44)
    }
    
   
    // MARK: ScrollView functions
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let target = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(target), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
    }
    
  
}
