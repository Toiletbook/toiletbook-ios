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
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var stars: StarView!
    @IBOutlet weak var locationPin: UIImageView!
    @IBOutlet weak var locationDescription: UILabel!
    @IBOutlet weak var areaPill: UIView!
    @IBOutlet weak var areaName: UILabel!
    @IBOutlet weak var establishmentPill: UIView!
    @IBOutlet weak var establishmentName: UILabel!
    @IBOutlet weak var deeplinkButton: UIButton!
    
    @IBOutlet weak var schedPill: UIView!
    @IBOutlet weak var pricePill: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    // MARK: - Action
    
    @IBAction func deepLinkButtonAction(_ sender: Any) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initUi()
    }
    
    func initUi() {
        initNavigationItem()
        
        name.text = washroom.name
        stars.setRating(washroom.general_rating, inTopThree: true, sponsored: washroom.is_sponsored.bool, whiteBg: true)
        locationPin.tintColor = Colors.dark.value
        locationDescription.text = washroom.location_description
        
        areaPill.layer.cornerRadius = areaPill.frame.height/2
        areaName.text = washroom.area_name
        
        establishmentPill.layer.cornerRadius = establishmentPill.frame.height/2
        establishmentName.text = washroom.establishment_name
        
        [schedPill, pricePill].forEach { (v) in
            v!.layer.cornerRadius = v!.frame.height/2
        }
        
        priceLabel.text = washroom.is_free.bool ? "FREE" : String("10 PHP") // washroom.entry_amount
        
    }
    
    func initNavigationItem() {
        navigationItem.titleView = UIImageView(image: #imageLiteral(resourceName: "logo-textual-purple"))
    }
    
}
