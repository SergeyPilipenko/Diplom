//
//  CinemaViewController.swift
//  DiplomMagistratura
//
//  Created by Admin on 28.02.17.
//  Copyright © 2017 SergeyPilipenko. All rights reserved.
//

import UIKit

class CinemaViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var headerlabel: UILabel!

    
    //MARK: - Variables
    
    var headerString: String?
   
    //MARK: - Functions
    
    func configureView() {
        
        headerlabel.text = headerString
    }
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
        configureView()
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
