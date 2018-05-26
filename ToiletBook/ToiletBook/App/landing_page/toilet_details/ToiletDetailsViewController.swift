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
    
    var portedView: UIView!
    
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var deeplinkButton: UIButton!
    @IBOutlet weak var attributeInfoView: UIView!
    @IBOutlet weak var dataView: UIView!
    
    @IBAction func deepLinkButtonAction(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUi()
        headerView.addSubview(portedView)
        (portedView as! ToiletTableViewCell).attributesStackView.isHidden = true
    }
    
    func initUi() {
        initNavigationItem()
        
    }
    
    func initNavigationItem() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo-textual-purple"))
    }
    
}
