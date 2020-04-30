//
//  ViewModel.swift
//  NYTimes
//
//  Created by Mohamed Ramadan on 4/30/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
   
}

class ViewModel: ViewModelType {
    
    let input = ViewModel.Input()
    
    let output = ViewModel.Output()
    
    private let disposeBag = DisposeBag()

    struct Input {
        let numOfDays = BehaviorRelay<Days>(value: .one)
        let fetchArticles = PublishSubject<Void>()
        
    }
    
    struct Output {
        let articleList = BehaviorRelay<[ArticlesList]>(value: [])
    }
    
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
    
    func setupAction(days: Days) -> Output {
        self.input.fetchArticles.subscribe({_ in
            ClientApi.getArticlesList(numOfDays: days) { [weak self ] (results) in
                self!.output.articleList.accept(results)
            }
            }).disposed(by: disposeBag)
        return self.output
    }
    
    func transformInputsToViewModel(input: Input)->Output {
        self.input.numOfDays.accept(input.numOfDays.value)
        let articlesList = self.setupAction(days: input.numOfDays.value)
        return articlesList
        
    }
    
   
    
    
}
