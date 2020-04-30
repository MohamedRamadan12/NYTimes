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

class ArticlesViewModelTest: XCTestCase {

    var scheduler: TestScheduler!
    var subscribtion: Disposable!
    var viewModel: ArticleViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ArticleViewModel()
        scheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        scheduler.scheduleAt(1000) {
            self.subscribtion.dispose()
        }
         super.tearDown()
    }
    
    
    func testNumOfdays(){
//        let selectedDayOsbservable = viewModel.numberOfDays.asObservable().subscribeOn(scheduler)
        viewModel.numberOfDays.accept(.seven)
        let result = viewModel.getDays(selectedIndex: 1)
        XCTAssertEqual(try viewModel.numberOfDays.toBlocking(timeout: 2).first(), result)
    }
    

  
}
