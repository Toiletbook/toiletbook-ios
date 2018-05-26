//
//  ToiletDetailsViewController.swift
//  ToiletBook
//
//  Created by Mark D. Rufino on 05/26/2018.
//  Copyright © 2018 Toilet Book Team. All rights reserved.
//

import UIKit

class ToiletDetailsViewController: UIViewController {

    var washroom: Washroom!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUi()
        print(washroom.toJSONString()!)
    }
    
    func initUi() {
        initNavigationItem()
        
    }
    
    func initNavigationItem() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo-textual-purple"))
    }
    
}
