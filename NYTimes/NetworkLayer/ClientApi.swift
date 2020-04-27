//
//  NetworkManager.swift
//  NYTimes
//
//  Created by Azza on 4/27/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import Foundation

class NetworkManager {
      func getArticlesList(numOfDays: Days, completion: @escaping (_ list: [ArticlesList]) -> Void){
            let endPoint = EndPoints.getArticlesList(numOfDays: numOfDays)

    //        apiClient.getArticles(numberOfDays) {
    //        }
            ApiClient.CallApi(endPoint: endPoint) { (result: Articles?, error: Error?, code) in
                print(result)
                guard let resultList = result?.results else { return }
                completion(resultList)
            }
        }
    
}
