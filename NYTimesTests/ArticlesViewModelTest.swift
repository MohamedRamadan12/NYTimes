//
//  ArticlesViewModelTest.swift
//  NYTimesTests
//
//  Created by Mohamed Ramadan on 4/29/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import RxBlocking

@testable import NYTimes

class TestClientAPI: ClientAPIType {
    var numberOfCalls = 0
    func getArticlesList(numOfDays: Days, completion: @escaping ([Article]) -> Void) {
        numberOfCalls += 1
        completion([])
    }
}

class ArticlesViewModelTest: XCTestCase {

    var viewModel: ArticleViewModel!
    let apiClient = TestClientAPI()
    
    override func setUp() {
        super.setUp()
        viewModel = ArticleViewModel(clientAPI: apiClient)
    }

    override func tearDown() {
         super.tearDown()
    }

    func testInit() {
        XCTAssertEqual(1, apiClient.numberOfCalls)
    }
    
    
    func testRefreshing() {
        viewModel.shouldRefresh.publish()
        try! viewModel.articles.toBlocking().last()
//        try! viewModel.articles.toBlocking().first()
        XCTAssertEqual(2, apiClient.numberOfCalls)
    }

    

  
}
