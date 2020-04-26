//
//  ArticlesViewModel.swift
//  NYTimes
//
//  Created by Mohamed Ramadan on 4/26/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import Foundation

class ArticleViewModel{
    
    func getArticlesList(numOfDays: Days, completion: @escaping (_ list: [ArticlesList]) -> Void){
        let endPoint = EndPoints.getArticlesList(numOfDays: numOfDays)
        ApiClient.CallApi(endPoint: endPoint) { (result: Articles?, error: Error?, code) in
            print(result)
            guard let resultList = result?.results else { return }
            completion(resultList)
        }
    }
}
