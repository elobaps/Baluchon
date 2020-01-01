//
//  ExchangeServiceTestCase.swift
//  BaluchonTests
//
//  Created by Elodie-Anne Parquer on 05/11/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

@testable import Baluchon
import XCTest

class ExchangeServiceTestCase: XCTestCase {
    func testGetExchange_WhenErrorIsOccured_ThenShouldReturnFailedCallBack() {
        //Given
        let exchangeService = ExchangeService(session:
            URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        exchangeService.getRate { result in
            guard case .failure(let error) = result else {
                XCTFail("The rate recovery request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetExchange_WhenDataIsNil_ThenShouldReturnFailedCallBack() {
          //Given
          let exchangeService = ExchangeService(session:
              URLSessionFake(data: nil, response: nil, error: nil))
          //When
          let expectation = XCTestExpectation(description: "Wait for queue change")
          exchangeService.getRate { result in
              guard case .failure(let error) = result else {
                  XCTFail("The rate recovery request method with an error failed")
                  return
              }
              XCTAssertNotNil(error)
              expectation.fulfill()
          }
          wait(for: [expectation], timeout: 0.01)
      }

    func testGetExchange_WhenResponseIsInccorect_ThenShouldReturnFailedCallBack() {
        //Given
        let exchangeService = ExchangeService(session:
            URLSessionFake(data: FakeResponseData.exchangeCorrectData,
            response: FakeResponseData.responseKO, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getRate { result in
            guard case .failure(let error) = result else {
                XCTFail("The rate recovery request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

    func testGetExchange_WhenDataIsInccorect_ThenShouldReturnFailedCallBack() {
          //Given
          let exchangeService = ExchangeService(session:
            URLSessionFake(data: FakeResponseData.exchangeIncorrectData,
            response: FakeResponseData.responseOK, error: nil))
          //When
          let expectation = XCTestExpectation(description: "Wait for queue change.")
          exchangeService.getRate { result in
              guard case .failure(let error) = result else {
                  XCTFail("The rate recovery request method with an error failed")
                  return
              }
              XCTAssertNotNil(error)
              expectation.fulfill()
          }
          wait(for: [expectation], timeout: 0.01)
      }

    func testGetExchange_WhenCorrectDataAndResponseArePassed_ThenShouldReturnFailedCallBack() {
        //Given
        let exchangeService = ExchangeService(session:
          URLSessionFake(data: FakeResponseData.exchangeCorrectData,
          response: FakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeService.getRate { result in
            guard case .success(let results) = result else {
                XCTFail("The rate recovery request method with an error failed")
                return
            }
            XCTAssertNotNil(results.date)
            XCTAssertNotNil(results.rates)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
