//
//  ArticlesViewModel.swift
//  NYTimes
//
//  Created by Mohamed Ramadan on 4/26/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ArticleViewModel {
    private let disposeBag = DisposeBag()
    
    let articles = BehaviorRelay<[ArticlesList]>(value: [])
    let numberOfDays = BehaviorRelay<Days>(value: Days.one)

    let fetchArticles = PublishSubject<Void>()
    
    func getDays(selectedIndex: Int)->Days {
        switch selectedIndex {
        case 0:
            return .one
        case 1:
            return .seven
        case 2:
            return .thirty
            
        default:
            return .one
        }
    }
    
    func setupAction() {
        fetchArticles.subscribe({_ in
            ClientApi.getArticlesList(numOfDays: self.numberOfDays.value) { [weak self ] (results) in
                           self?.articles.accept(results)
            }
            }).disposed(by: disposeBag)
        
        
    }

    init() {
       setupAction()
    }
}
