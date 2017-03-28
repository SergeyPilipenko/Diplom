//
//  FilmsCollectionViewController.swift
//  DiplomMagistratura
//
//  Created by Admin on 18.03.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import UIKit


class FilmsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
       
        // Register cell classes
        self.collectionView!.register(FilmCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        self.collectionView?.contentInset = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        self.collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 44, left: 0, bottom: 0, right: 0)
        setupSearchBar()
        setupMenuBar()
        setupNavigationBar()
        
        // Do any additional setup after loading the view.
    }
    
    func setupNavigationBar(){
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.hidesBarsOnSwipe = true
        
        let filterImage = UIImage(named: "navi_back_btn")
        let filterBarButtonItem = UIBarButtonItem(image: filterImage, style: .plain, target: self, action: #selector(handleFilter))
        navigationItem.rightBarButtonItems = [filterBarButtonItem]
    }
    

    let filterLauncher = Filterlauncher()
    
    func handleFilter() {
        
          filterLauncher.showLauncher()
    }
    
 
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar(){
        
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        view.addSubview(whiteView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: whiteView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: whiteView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true

    }
    
    func setupSearchBar() {
        let searchBar = UISearchBar()
       // searchBar.showsCancelButton = false
        searchBar.placeholder = "Введите название фильма"
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        self.navigationItem.titleView = searchBar
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 5
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilmCollectionViewCell
    
    
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 77)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
}
