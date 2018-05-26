//
//  ToiletTableViewCell.swift
//  ToiletBook
//
//  Created by Mark D. Rufino on 05/26/2018.
//  Copyright © 2018 Toilet Book Team. All rights reserved.
//

import UIKit

class ToiletTableViewCell: UITableViewCell {
    
    static let identifier = "ToiletTableViewCell"
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var starView: StarView!
    
    @IBOutlet weak var locationDescription: UILabel!
    
    @IBOutlet weak var areaNamePill: UIView!
    @IBOutlet weak var areaNameLabel: UILabel!
    @IBOutlet weak var establishmentNamePill: UIView!
    @IBOutlet weak var establishmentNameLabel: UILabel!
    
    @IBOutlet weak var bidetImageView: UIImageView!
    @IBOutlet weak var infantImageView: UIImageView!
    @IBOutlet weak var pwdImageView: UIImageView!
    @IBOutlet weak var tissueImageView: UIImageView!
    @IBOutlet weak var vendorImageView: UIImageView!
    @IBOutlet weak var waterImageView: UIImageView!
    @IBOutlet weak var genderImageView: UIImageView!
    @IBOutlet weak var paymentImageView: UIImageView!
    
    
    func set(_ washroom: Washroom) {
    }
    
    func initUI() {
        areaNamePill.layer.cornerRadius = areaNamePill.frame.height/2
        establishmentNamePill.layer.cornerRadius = establishmentNamePill.frame.height/2
        initAttributeImages()
    }
    
    func initAttributeImages() {
        bidetImageView.image = Attribute.bidet.icon
        infantImageView.image = Attribute.infant.icon
        pwdImageView.image = Attribute.pwd.icon
        tissueImageView.image = Attribute.tissue.icon
        vendorImageView.image = Attribute.vendor.icon
        waterImageView.image = Attribute.water.icon
        genderImageView.image = Attribute.gender(SubAttributeGender.female).icon
        paymentImageView.image = Attribute.payment(SubAttributePayment.free).icon
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initUI()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
