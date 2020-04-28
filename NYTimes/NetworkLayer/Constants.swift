//
//  Constants.swift
//  NYTimes
//
//  Created by Mohamed Ramadan on 4/26/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import Foundation


enum Days: Int {
    case one = 1
    case seven = 7
    case thirty = 30
    var day : Int {
           return rawValue
       }
    
    public init?(index: Int) {
           switch index {
           case 0: self = .one
           case 1: self = .seven
           case 2: self = .thirty
           default: return nil
           }
}
}
