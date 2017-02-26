//
//  MapViewController.swift
//  DiplomMagistratura
//
//  Created by Admin on 26.02.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        //Bundle.main.path(forResource: "MapHTMLCode", ofType: "html")
        //if let path = Bundle.main.path(forResource: "MapHTMLCode", ofType: "html", inDirectory: "Supports")
          if let path =  Bundle.main.path(forResource: "MapHTMLCode", ofType: "html") {
            print("ok")
            let url = URL(fileURLWithPath: path)
            webView.loadRequest(URLRequest(url: url))
          }else{
            print("not ok")
        }
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
