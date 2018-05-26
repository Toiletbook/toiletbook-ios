//
//  Attribute.swift
//  ToiletBook
//
//  Created by Mark D. Rufino on 05/26/2018.
//  Copyright © 2018 Toilet Book Team. All rights reserved.
//

import Foundation
import UIKit

enum SubAttributeGender {
    case female
    case male
    case unisex
}

enum SubAttributePayment {
    case free
    case paid
}

enum Attribute {
    
    case bidet
    case infant
    case pwd
    case tissue
    case vendor
    case water
    case gender(SubAttributeGender)
    case payment(SubAttributePayment)
    
    var icon: UIImage {
        switch self {
        case .bidet:
            return #imageLiteral(resourceName: "atr-bidet")
        case .infant:
            return #imageLiteral(resourceName: "atr-infant")
        case .pwd:
            return #imageLiteral(resourceName: "atr-pwd")
        case .tissue:
            return #imageLiteral(resourceName: "atr-tissue")
        case .vendor:
            return #imageLiteral(resourceName: "atr-vendor")
        case .water:
            return #imageLiteral(resourceName: "atr-water")
        case .gender(let subGender):
            
            switch subGender {
            case .male:
                return #imageLiteral(resourceName: "atr-gender-male")
            case .female:
                return #imageLiteral(resourceName: "atr-gender-female")
            case .unisex:
                return #imageLiteral(resourceName: "atr-gender-unisex")
            }
            
        case .payment(let subPayment):
            switch subPayment {
            case .free:
                return #imageLiteral(resourceName: "atr-payment-free")
            case .paid:
                return #imageLiteral(resourceName: "atr-payment-paid")
            }
        }
    }
    
}
