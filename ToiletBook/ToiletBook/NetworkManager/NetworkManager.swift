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

typealias GetWashroomsHandler = (([Washroom]) -> Void)

//Route::get('/washrooms', 'WashroomController@index');
//Route::get('/washrooms/{id}', 'WashroomController@show');
//Route::post('/washrooms', 'WashroomController@store');
//
//Route::put('/washrooms/{id}', 'WashroomController@update');
//Route::delete('/washrooms/{id}', 'WashroomController@destroy');
//
//Route::post('/washrooms/{id}/visit', 'WashroomController@visit');
//
//Route::get('/areas', 'AreaController@index');
//Route::get('/areas/{id}', 'AreaController@show');
//
//Route::get('/establishments', 'EstablishmentController@index');
//Route::get('/establishments/{id}', 'EstablishmentController@show');

class NetworkManager {
    
    static let instance = NetworkManager()
    
    let baseUrl: URL =  URL.init(string: "http://toiletbook.space")!
    
    let baseHeader: HTTPHeaders = [:]
    
    enum Endpoints {
        
    }
    
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



