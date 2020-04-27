//
//  ArticlesViewModel.swift
//  NYTimes
//
//  Created by Mohamed Ramadan on 4/26/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import Foundation

class ArticleViewModel{
    var Articales : [ArticlesList]?
    func callApi(numberOfDayes: Days) {
        ClientApi.getArticlesList(numOfDays: numberOfDayes) { [weak self ] (results) in
            self?.Articales = results
        }
    }
    
}
