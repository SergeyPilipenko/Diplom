//
//  CinemaViewController.swift
//  DiplomMagistratura
//
//  Created by Admin on 28.02.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import UIKit

class CinemaViewController: UIViewController, UIScrollViewDelegate {

   
    // MARK: - IBOutlets
    
    @IBOutlet weak var webView: UIWebView!


   
    
    //MARK: - Variables
    
    var headerString: String?
    var webViewk: UIWebView {
        let wv = UIWebView(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.width/2))
        return wv
    }
   
    //MARK: - Functions
    
    func configureView() {
        
        
    }
    
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //webView.frame = webViewk.frame
        navigationController?.setNavigationBarHidden(false, animated: true)
        let viewK = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
        viewK.backgroundColor = UIColor.clear
        navigationController?.navigationItem.titleView = viewK
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //navigationController?.setNavigationBarHidden(false, animated: true)
       // navigationController?.navigationBar.backgroundColor = UIColor.clear
        //configureView()
        if let path =  Bundle.main.path(forResource: "MapHTMLCode", ofType: "html") {
            print("ok")
            let url = URL(fileURLWithPath: path)
            webView.loadRequest(URLRequest(url: url))
        }else{
            print("not ok")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    
    }

       /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
