//
//  Washroom.swift
//  ToiletBook
//
//  Created by Mark D. Rufino on 05/26/2018.
//  Copyright © 2018 Toilet Book Team. All rights reserved.
//

import Foundation
import ObjectMapper

class Washroom: Mappable {
    
    var lat: Double!
    var long: Double! 
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
    }
    
}
