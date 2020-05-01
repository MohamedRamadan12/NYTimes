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
    let disposeBag = DisposeBag()
    let clientAPI: ClientAPIType

    let isRefreshing = BehaviorRelay<Bool>(value: false)
    let articles = BehaviorRelay<[Article]>(value: [])
    let days = BehaviorRelay<Int>(value: 0)

    let shouldRefresh = PublishSubject<Void>()


    init(clientAPI: ClientAPIType) {
        self.clientAPI = clientAPI
        
        shouldRefresh.debug().subscribe( onNext: {_ in
            self.isRefreshing.accept(true)
            clientAPI.getArticlesList(numOfDays: Days(index: self.days.value) ?? Days.one) { [weak self ] (results) in
                self?.isRefreshing.accept(false)
                self?.articles.accept(results)
            }
        }).disposed(by: disposeBag)

        days.map {_ in
            return Void()
        }.debug("Days triggered").bind(to: shouldRefresh).disposed(by: disposeBag)
    }
}
