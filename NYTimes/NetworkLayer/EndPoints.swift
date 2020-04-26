//
//  EndPointsd.swift
//  NYTimes
//
//  Created by Mohamed Ramadan on 4/26/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import Foundation
import Alamofire

enum EndPoints: APIConfigurations {

    
    case getArticlesList(numOfDays: Days)
    
    var method: HTTPMethod {
        return .get
    }
    
    internal var encoding: ParameterEncoding {
           switch method {
           case .get:
               return URLEncoding.default
           case .post:
             return  JSONEncoding.default
           default:
              return JSONEncoding.default
       }
       }
    
    var path: String {
        switch self {
        case .getArticlesList(let numOfdays):
            return "\(numOfdays.day)\(Constants.apiKey)"
   
        }
        
    }
    
    var parameters: Parameters? {
        return nil 
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = Constants.baseUrl + path
        
        let finalURl = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlRequest = URLRequest(url: URL(string: finalURl)!)

        return urlRequest
    }
    
}
