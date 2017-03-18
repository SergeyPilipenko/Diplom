//
//  CinemaTableViewController.swift
//  DiplomMagistratura
//
//  Created by Admin on 04.03.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import UIKit
import Alamofire


import UIKit

class CinemaTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var cinema: Cinema?
    var header : StretchHeader!
    var tableView : UITableView!
    var navigationView = UIView()
    var favoriteButton : UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
          favoriteButton.setTitleColor(isFavorite ? UIColor.red : UIColor.lightGray, for: UIControlState())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        setupHeaderView()
        
        // NavigationHeader
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
        label.text = cinema?.name
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
        
        tableView.tableHeaderView  = header
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        header.updateScrollViewOffset(scrollView)
        
        // NavigationHeader alpha update
        let offset : CGFloat = scrollView.contentOffset.y
        if (offset > 50) {
            let alpha : CGFloat = min(CGFloat(1), CGFloat(1) - (CGFloat(50) + (navigationView.frame.height) - offset) / (navigationView.frame.height))
            navigationView.alpha = CGFloat(alpha)
            
        } else {
            navigationView.alpha = 0.0;
        }
    }
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.label.text = String(describing: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(section)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 15))
        view.backgroundColor = UIColor.white
        let label = UILabel()
        label.frame = view.frame
        label.text = String(section)
        label.textColor = UIColor.orange
        label.textAlignment = .center
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 0))
        view.backgroundColor = UIColor.white
        return view
    }
    
}
