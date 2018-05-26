//
//  Colors.swift
//  ToiletBook
//
//  Created by Mark D. Rufino on 05/26/2018.
//  Copyright © 2018 Toilet Book Team. All rights reserved.
//

import Foundation
import UIKit

enum Colors {
    
    case main
    case mainLight
    case dark
    
    var value: UIColor {
        switch self {
        case .main:
            return UIColor(displayP3Red: 99/255, green: 89/255, blue: 128/255, alpha: 1.0)
        case .mainLight:
            return UIColor(displayP3Red: 178/255, green: 151/255, blue: 172/255, alpha: 1.0)
        case .dark:
            return UIColor(displayP3Red: 80/255, green: 67/255, blue: 77/255, alpha: 1.0)
        }
    }
    
}
