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

class CinemaDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Constants and variables
    var cinema: Cinema?
    var titlesArray = ["Адрес:", "Сайт:", "Автоответчик:", "Заказ билетов:"]
    var detailDictionary: [Int: String] = Dictionary()
    var isFavorite = false
    var header: UIView!
    var tableView : UITableView!
    var navigationView = UIView()
    var favoriteButton : UIButton!
    
    let cellId = "cellId"
    let filmsCellId = "filmCellId"
    
    // MARK: - Support functions
    func setupTableView() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.bounces = false
       // tableView.allowsSelection = false
        tableView.estimatedRowHeight = 20
        view.addSubview(tableView)
        tableView.register(CinemaDescriptionCell.self, forCellReuseIdentifier: cellId)
        tableView.register(CinemaFilmsCell.self, forCellReuseIdentifier: filmsCellId)
    }
    
    func setupNavigationView(){
        
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
        backButton.addTarget(self, action: #selector(CinemaDetailViewController.leftButtonAction), for: .touchUpInside)
        view.addSubview(backButton)
    }
    
    func setupHeaderView() {
        
        header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width/2+22))
        
        header.backgroundColor = UIColor.lightText
        
        let webView = UIWebView()
        webView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.width/2)
        webView.isUserInteractionEnabled = false
        webView.scalesPageToFit = true
        
        let url = URL(string: "https://static-maps.yandex.ru/1.x/?l=map&ll=39.204365,51.661937&z=16&size=500,400&pt=39.204365,51.661937,pm2dgm")!
        let request = URLRequest(url: url)
        webView.loadRequest(request)
        header.addSubview(webView)
        
        favoriteButton = UIButton(type: .custom)
        favoriteButton.frame = CGRect(x: header.frame.width-64, y: header.frame.height-46, width: 44, height: 44)
        
        favoriteButton.layer.cornerRadius = 22
        favoriteButton.backgroundColor = UIColor.white
        favoriteButton.setTitle("1", for: UIControlState())
        favoriteButton.addTarget(self, action: #selector(addFavorite), for: .touchUpInside)
        header.addSubview(favoriteButton)
        
        tableView.tableHeaderView  = header
    }
    
    // MARK: - Selector
    func leftButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func addFavorite() {
        isFavorite =  !isFavorite
        favoriteButton.setTitleColor(isFavorite ? UIColor.red : UIColor.lightGray, for: UIControlState())
    }

    // MARK: - ViewConfiguration
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil;
          favoriteButton.setTitleColor(isFavorite ? UIColor.red : UIColor.lightGray, for: UIControlState())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupHeaderView()
        setupNavigationView()
        
        detailDictionary[0] = cinema?.adress
        detailDictionary[1] = cinema?.site
        detailDictionary[2] = cinema?.autoresponderPhone
        detailDictionary[3] = cinema?.reservedPhone
    }
    

    // MARK: - ScrollView Delegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // NavigationHeader alpha update
        let offset : CGFloat = scrollView.contentOffset.y
        if (offset > 50) {
            let alpha : CGFloat = min(CGFloat(1), CGFloat(1) - (CGFloat(50) + (navigationView.frame.height) - offset) / (navigationView.frame.height))
            navigationView.alpha = CGFloat(alpha)
            
        } else {
            navigationView.alpha = 0.0;
        }
        
    }
    
    // MARK: - TableView configuration
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
           return titlesArray.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CinemaDescriptionCell
            cell.titleLabel.text = titlesArray[indexPath.row]
            cell.detaillabel.text = detailDictionary[indexPath.row]
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: filmsCellId, for: indexPath) as! CinemaFilmsCell
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath.section == 0) {
            switch indexPath.row {
            case 1:
               
                let url = URL(string: "https://"+detailDictionary[indexPath.row]!)!
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
                
            case 2,3:
                print("SELECTED")
                print(detailDictionary[indexPath.row]!)
                let tel =  URL(string: "tel://"+detailDictionary[indexPath.row]!)!
                print(tel)
                if #available(iOS 10.0, *) {
                   UIApplication.shared.open(tel, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(tel)
                }
            default:
                break
            }

        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0 {
            return UITableViewAutomaticDimension
        } else {
            return (view.frame.height - 16)
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }

    
    
}
