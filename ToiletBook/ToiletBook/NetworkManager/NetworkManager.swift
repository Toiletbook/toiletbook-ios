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
    
    let baseUrl: String = "https://toiletbook.space/api/"
    
    let baseHeader: HTTPHeaders = ["Accept": "application/json", "Content-Type":"application/json"]
    
    enum Endpoints {
        // washrooms
        case getWashrooms
        case getEstablishmentWashrooms(establishmentId: String)
        case getWashroom(id: String)
        case postWashrooms
        case updateWashroom(id: String)
        case deleteWashroom(id: String)
        
        // review
        case visitWashroom(id: String)
        
//        // areas
//        case getAreas
//        case getArea(id: String)
        
        // establishments
        case establishments
        case establishment(id: String)
        
        var path: String {
            switch self {
            case .getEstablishmentWashrooms(let id):
                return "establishments/\(id)/washrooms"
            case .getWashroom(let id), .updateWashroom(let id), .deleteWashroom(let id):
                return "washrooms/\(id)"
            case .postWashrooms:
                return "washrooms"
            case .visitWashroom(let id):
                return "washrooms/\(id)/visit"
            case .establishments:
                return "establishments"
            case .establishment(let id):
                return "establishments/\(id)"
            case .getWashrooms:
                return "washrooms"
            }
        }
        
        var method: HTTPMethod {
            switch self {
            case .getEstablishmentWashrooms,
                 .getWashroom,
                 .establishments,
                 .establishment,
                 .getWashrooms:
                return .get
            case .postWashrooms,
                 .visitWashroom:
                return .post
            case .updateWashroom:
                return .put
            case .deleteWashroom:
                return .delete
            }
        }
        
    }
    
    
    func request<U: BaseMappable>(endpoint: Endpoints, handler: @escaping ((DataResponse<U>) -> Void) ) {
    
        let url = URL(string: baseUrl + endpoint.path)!
        let request = Alamofire.request(url, method: endpoint.method, parameters: [:], encoding: JSONEncoding.default, headers: baseHeader)
        request.responseObject(completionHandler: handler)
    
    }
    
    func requestArray<U: BaseMappable>(endpoint: Endpoints, handler: @escaping ((DataResponse<[U]>) -> Void) ) {
        
        let url = URL(string: baseUrl + endpoint.path)!
        let request = Alamofire.request(url, method: endpoint.method, parameters: [:], encoding: JSONEncoding.default, headers: baseHeader)
        request.responseArray(completionHandler: handler)
        
    }
    
}



