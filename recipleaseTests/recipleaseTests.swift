//
//  recipleaseTests.swift
//  recipleaseTests
//
//  Created by Darrieumerlou on 17/10/2019.
//  Copyright © 2019 Darrieumerlou. All rights reserved.
//

import XCTest
@testable import Alamofire
@testable import reciplease

    final class APIIngredientsTest: XCTestCase {
        
        private var sut: APIIngredients!
        
        override func setUp() {
            super.setUp()
            
            let manager: SessionManager = {
                let configuration: URLSessionConfiguration = {
                    let configuration = URLSessionConfiguration.default
                    configuration.protocolClasses = [MockURLProtocol.self]
                    return configuration
                }()
                
                return SessionManager(configuration: configuration)
            }()
            sut = APIIngredients(manager: manager)
        }
        
        override func tearDown() {
            super.tearDown()
            
            sut = nil
        }
        
        func testStatusCode200ReturnsStatusCode200() {
            // given
            MockURLProtocol.responseWithStatusCode(code: 200)
            
            let expectation = XCTestExpectation(description: "Performs a request")
            
            // when
            sut.execute(["chicken"]) { (result) in
                XCTAssertEqual((result as AnyObject).statusCode, 200);
                expectation.fulfill()
            }
            
            // then
            wait(for: [expectation], timeout: 3)
    }


}
