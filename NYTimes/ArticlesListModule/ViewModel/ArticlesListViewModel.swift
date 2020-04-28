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
    init(numOfDays: Driver<Days>) {
           numOfDays
               .drive(onNext: { [weak self] (numOfDays) in
                self?.callApi(numberOfDayes: numOfDays)
           }).disposed(by: disposeBag)
       }
    
    private let disposeBag = DisposeBag()
    func callApi(numberOfDayes: Days) {
        self._articles.accept([])
        ClientApi.getArticlesList(numOfDays: numberOfDayes) { [weak self ] (results) in
            self?._articles.accept(results)
        }
    }
    
    private let _articles = BehaviorRelay<[ArticlesList]>(value: [])
    var articales: Driver<[ArticlesList]> {
               return _articles.asDriver()
           }
    var numberOfArticles: Int {
              return _articles.value.count
          }

    func viewModelForArticle(at index: Int) -> ArticlesViewModel? {
           guard index < _articles.value.count else {
               return nil
           }
        return ArticlesViewModel(article: _articles.value[index])
       }
}
