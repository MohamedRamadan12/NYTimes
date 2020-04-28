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

    init() {

        _ = fetchArticles.map {_ in
            ClientApi.getArticlesList(numOfDays: self.numberOfDays.value) { [weak self ] (results) in
                self?.articles.accept(results)
            }
        }

        fetchArticles.onNext()

    }
}
