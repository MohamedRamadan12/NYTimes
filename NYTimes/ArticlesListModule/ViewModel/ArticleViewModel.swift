//
//  ArticleViewModel.swift
//  NYTimes
//
//  Created by Azza on 4/28/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import Foundation

struct ArticlesViewModel {
    
    private var article: ArticlesList
    init(article: ArticlesList) {
        self.article = article
    }
    
    var title: String {
        return article.title
    }
    
    var detail: String {
            let articlee = article.abstract
            let nsString = articlee as NSString
            var articleLine = ""
            if nsString.length >= 10
            {
             // making description of only 20 characters with (click to continue) sentence
                let customLength = "\(nsString.substring(with: NSRange(location: 0, length: nsString.length > 20 ? 20 : nsString.length)))"
                let continueTxt = "... click to continue"
                articleLine = customLength + continueTxt
        }
        return articleLine
    }
}
  
