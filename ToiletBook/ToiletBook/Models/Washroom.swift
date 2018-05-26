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
    
    var gender_is_female_only: Int!
    var visitor_stats: [visitor_statsObject]!
    var updated_at: String!
    var has_vending_machine: Int!
    var entry_amount: Int!
    var has_water: Int!
    var is_pwd_friendly: Int!
    var id: Int!
    var general_rating: Double!
    var has_diaper_station: Int!
    var need_membership: Int!
    var gender_is_unisex: Int!
    var latitude: Double!
    var is_sponsored: Int!
    var has_bidet: Int!
    var has_shower: Int!
    var open_hours: String!
    var has_soap: Int!
    var is_free: Int!
    var has_wifi: Int!
    var has_tissues: Int!
    var establishment_id: Int!
    var visits: Int!
    var name: String!
    var created_at: String!
    var longitude: Double!
    var washroom_attributes: [washroom_attributesObject]!
    var location_description: String!
    var has_tv: Int!
    var gender_is_male_only: Int!
    var gender_has_both: Int!
    var area_name: String!
    var establishment_name: String!
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        gender_is_female_only <- map["gender_is_female_only"]
        visitor_stats <- map["visitor_stats"]
        updated_at <- map["updated_at"]
        has_vending_machine <- map["has_vending_machine"]
        entry_amount <- map["entry_amount"]
        has_water <- map["has_water"]
        is_pwd_friendly <- map["is_pwd_friendly"]
        id <- map["id"]
        general_rating <- map["general_rating"]
        has_diaper_station <- map["has_diaper_station"]
        need_membership <- map["need_membership"]
        gender_is_unisex <- map["gender_is_unisex"]
        latitude <- map["latitude"]
        is_sponsored <- map["is_sponsored"]
        has_bidet <- map["has_bidet"]
        has_shower <- map["has_shower"]
        open_hours <- map["open_hours"]
        has_soap <- map["has_soap"]
        is_free <- map["is_free"]
        has_wifi <- map["has_wifi"]
        has_tissues <- map["has_tissues"]
        establishment_id <- map["establishment_id"]
        visits <- map["visits"]
        name <- map["name"]
        created_at <- map["created_at"]
        longitude <- map["longitude"]
        washroom_attributes <- map["washroom_attributes"]
        location_description <- map["location_description"]
        has_tv <- map["has_tv"]
        gender_is_male_only <- map["gender_is_male_only"]
        gender_has_both <- map["gender_has_both"]
        area_name <- map["establishment.area.name"]
        establishment_name <- map["establishment.name"]
    }
}

class visitor_statsObject: Mappable {
    var count: Int!
    var hour: Int!
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        count <- map["count"]
        hour <- map["hour"]
    }
}

class washroom_attributesObject: Mappable {
    var average_rating: Int!
    var name: String!
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        average_rating <- map["average_rating"]
        name <- map["name"]
    }
}

