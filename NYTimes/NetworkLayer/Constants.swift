//
//  Constants.swift
//  NYTimes
//
//  Created by Mohamed Ramadan on 4/26/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import Foundation

struct Constants {
    
    static let baseUrl = "https://api.nytimes.com/svc/mostpopular/v2/viewed/"
    static let apiKey = ".json?api-key=XxCxgOxWhL6WVwdaJ5zNSYpYunISHuOB"
}

enum Days: Int {
    case one = 1
    case seven = 7
    case thirty = 30
    var day : Int {
           return rawValue
       }
}
