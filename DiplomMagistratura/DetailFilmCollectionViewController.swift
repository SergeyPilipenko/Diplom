//
//  DetailFilmCollectionViewController.swift
//  DiplomMagistratura
//
//  Created by Admin on 29.03.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class DetailFilmCollectionViewController: UICollectionViewController {

    var navigationView = UIView()
    var favoriteButton : UIButton!
    var header : StretchHeader!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.backgroundColor = .green
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
        let navibarHeight : CGFloat = navigationController!.navigationBar.bounds.height
        let statusbarHeight : CGFloat = UIApplication.shared.statusBarFrame.size.height
        navigationView = UIView()
        navigationView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: navibarHeight + statusbarHeight)
        navigationView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 0.99)
        navigationView.alpha = 0.0
        view.addSubview(navigationView)
        
        // I will add this (navigationbar titlelabel)
        let label = UILabel()
        label.frame = CGRect(x: 0, y: statusbarHeight, width: view.frame.size.width, height: navibarHeight)
        label.text = "Tratata"
        label.textAlignment = .center
        label.textColor = UIColor.green
        navigationView.addSubview(label)
        
        
        let backButton = UIButton(type: .custom)
        backButton.frame = CGRect(x: 10, y: 20, width: 44, height: 44)
        backButton.setImage(UIImage(named: "navi_back_btn")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
        backButton.tintColor = UIColor.green
        backButton.addTarget(self, action: #selector(CinemaTableViewController.leftButtonAction), for: .touchUpInside)
        view.addSubview(backButton)
    }
    
    func setupHeaderView() {
        
        let options = StretchHeaderOptions()
        options.position = .fullScreenTop
        
        header = StretchHeader()
        header.stretchHeaderSize(headerSize: CGSize(width: view.frame.size.width, height: view.frame.size.width/2+22),
                                 imageSize: CGSize(width: view.frame.size.width, height: view.frame.size.width/2),
                                 controller: self,
                                 options: options)
        header.backgroundColor = UIColor.white
        let webView = UIWebView()
        webView.frame = header.conteinerView.frame
        webView.isUserInteractionEnabled = false
        
        
        let url = URL(string: "https://static-maps.yandex.ru/1.x/?l=map&ll=39.204365,51.661937&z=16&size=320,160&pt=39.204365,51.661937,pm2dgm")!
        let request = URLRequest(url: url)
        webView.loadRequest(request)
        header.conteinerView.addSubview(webView)
        
        
        favoriteButton = UIButton(type: .custom)
        favoriteButton.frame = CGRect(x: header.conteinerView.frame.width-64, y: header.conteinerView.frame.height-22, width: 44, height: 44)
        
        favoriteButton.layer.cornerRadius = 22
        favoriteButton.backgroundColor = UIColor.white
        favoriteButton.setTitle("1", for: UIControlState())
        favoriteButton.addTarget(self, action: #selector(addFavorite), for: .touchUpInside)
        header.addSubview(favoriteButton)
        
    }
    
    var isFavorite = false
    func addFavorite() {
        isFavorite =  !isFavorite
        favoriteButton.setTitleColor(isFavorite ? UIColor.red : UIColor.lightGray, for: UIControlState())
    }
    
    // MARK: - Selector
    func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - ScrollView Delegate
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
       // header.updateScrollViewOffset(scrollView)
        
        // NavigationHeader alpha update
        let offset : CGFloat = scrollView.contentOffset.y
        if (offset > 50) {
            let alpha : CGFloat = min(CGFloat(1), CGFloat(1) - (CGFloat(50) + (navigationView.frame.height) - offset) / (navigationView.frame.height))
            navigationView.alpha = CGFloat(alpha)
            
        } else {
            navigationView.alpha = 0.0;
        }
    }
    
     func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            var headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Header", for: indexPath as IndexPath)
            
            
            return headerView
            
        default:
            
            assert(false, "Unexpected element kind")
        }
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

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
        return cell
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
