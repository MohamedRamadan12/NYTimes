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
    func testAmb() {
      // 2
    let observer = scheduler.createObserver(String.self)
        let observableA = scheduler.createHotObservable([ // 2
        Recorded.next(100, "a"), Recorded.next(200, "b"), Recorded.next(300, "c")
        ])
        let observableB = scheduler.createHotObservable([ // 4
        Recorded.next(90, "1"), Recorded.next(200, "2"), Recorded.next(300, "3")
        ])
        let ambObservable = observableA.amb(observableB)
        self.subscribtion = ambObservable.subscribe(observer)
        scheduler.start()
        let results = observer.events.compactMap {
        $0.value.element
        }
        XCTAssertEqual(results, ["1", "2", "3"])
//        XCTAssertEqual(results, ["1", "2", "No you didn't!"])

    }
    
    func testNumOfdays(){
//        let selectedDayOsbservable = viewModel.numberOfDays.asObservable().subscribeOn(scheduler)
        viewModel.numberOfDays.accept(.seven)
        let result = viewModel.getDays(selectedIndex: 1)
        XCTAssertEqual(try viewModel.numberOfDays.toBlocking(timeout: 2).first(), result)
    }
    
    func testFilter() {
      // 1
    let observer = scheduler.createObserver(Int.self)
    // 2
    let observable = scheduler.createHotObservable([ Recorded.next(100, 1),
    Recorded.next(200, 2),
    Recorded.next(300, 3),
    Recorded.next(400, 2),
    Recorded.next(500, 1) ])
    // 3
    let filterObservable = observable.filter {
    $0 < 3 }
    // 4
    scheduler.scheduleAt(0) {
    self.subscribtion = filterObservable.subscribe(observer) }
    // 5
    scheduler.start()
    // 6
    let results = observer.events.compactMap {
    $0.value.element }
    // 7
      XCTAssertEqual(results, [1, 2, 2, 1])
    }
    
    func testToArray() throws {
      // 1
    let scheduler = ConcurrentDispatchQueueScheduler(qos: .default) // 2
    let toArrayObservable = Observable.of(1, 2).subscribeOn(scheduler)
    // 3
    XCTAssertEqual(try toArrayObservable.toBlocking().toArray(), [1, 2])
        
    }
    
    func testToArrayMaterialized() {
      // 1
    let scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
    let toArrayObservable = Observable.of(1, 2).subscribeOn(scheduler)
    // 2
    let result = toArrayObservable .toBlocking()
    .materialize()
    // 3
    switch result {
    case .completed(let elements):
    XCTAssertEqual(elements, [1, 2]) case .failed(_, let error):
    XCTFail(error.localizedDescription) }
    }
}
