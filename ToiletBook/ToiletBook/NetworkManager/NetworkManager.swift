//
//  NetworkManager.swift
//  ToiletBook
//
//  Created by Mark D. Rufino on 05/26/2018.
//  Copyright © 2018 Toilet Book Team. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper
import Foundation
import ObjectMapper

// 3 endpoints
// - washrooms get
// - washroom ( id ) info
// - vist ( id )

typealias GetWashroomsHandler = (([Washroom]) -> Void)

class NetworkManager {
    
    static let instance = NetworkManager()
    
    
    let baseUrl: URL =  URL.init(string: "http://toiletbook.space")!
    
    let baseHeader: HTTPHeaders = [:]
    
    
    func getWashrooms(_ handler: @escaping GetWashroomsHandler) {
        let request = Alamofire.request(baseUrl, method: .get, parameters: [:], encoding: JSONEncoding.default, headers: baseHeader)
        request.responseArray { (resp: DataResponse<[Washroom]>) in
            switch resp.result {
            case .success(let washrooms):
                handler(washrooms)
            case .failure(let error):
                error.localizedDescription.errorPrint()
            }
        }
    }
    
    func getWashroomInfo(withId id: Int) {
        
    }
    
    func postVisitFeedback(toWashroomId id: Int) {
        
    }
    
}



