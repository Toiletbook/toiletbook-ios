//
//  Toilet.swift
//  ToiletBook
//
//  Created by Mark D. Rufino on 05/26/2018.
//  Copyright © 2018 Toilet Book Team. All rights reserved.
//

import Foundation
import ObjectMapper

class Toilet: Mappable {
    
    var rating: Double!
    var isTopThree: Bool!
    
    init(rating: Double, isTopThree: Bool) {
        self.rating = rating
        self.isTopThree = isTopThree
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
    }
    
}
