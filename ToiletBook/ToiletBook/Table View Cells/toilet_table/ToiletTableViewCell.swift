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
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
