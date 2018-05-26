//
//  NetworkManager.swift
//  ToiletBook
//
//  Created by Mark D. Rufino on 05/26/2018.
//  Copyright © 2018 Toilet Book Team. All rights reserved.
//

import Alamofire
import Foundation
import ObjectMapper

// 3 endpoints
// - washrooms get
// - washroom ( id ) info
// - vist ( id )

typealias GetWashroomsHandler = (([Washroom]) -> Void)

class NetworkManager {
    
    static let instance = NetworkManager()
    
    
    let baseUrl: URL =  URL.init(string: "https://test.com")!
    
    let baseHeader: HTTPHeaders = [:]
    
    
    func getWashrooms(_ handler: GetWashroomsHandler) {
        
        let parameters: Parameters = [:]
        let request = Alamofire.request(baseUrl, method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: baseHeader)
        
        request.responseJSON { (r) in
            
            switch r.result {
            case .success(let value):
                
                let data = Mapper<
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }

    }
    
    func getWashroomInfo(withId id: Int) {
        
    }
    
    func postVisitFeedback(toWashroomId id: Int) {
        
    }
    
}



