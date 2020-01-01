//
//  TranslateServiceTestCase.swift
//  BaluchonTests
//
//  Created by Elodie-Anne Parquer on 20/11/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

@testable import Baluchon
import XCTest

class TranslateServiceTestCase: XCTestCase {
    
    private var language = "en"

    func testGetTranslation_WhenErrorIsOccured_ThenShouldReturnFailedCallBack() {
         //Given
         let translateService = TranslateService(session:
             URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
         //When
         let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslation(text: "Bonjour", target: language) { result in
             guard case .failure(let error) = result else {
                 XCTFail("The translation request method with an error failed")
                 return
             }
             XCTAssertNotNil(error)
             expectation.fulfill()
         }
         wait(for: [expectation], timeout: 0.01)
     }
    
    func testGetLanguages_WhenErrorIsOccured_ThenShouldReturnFailedCallBack() {
        //Given
        let translateService = TranslateService(session:
            URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
       translateService.getLanguages { result in
            guard case .failure(let error) = result else {
                XCTFail("The translation request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslation_WhenDataIsNil_ThenShouldReturnFailedCallBack() {
         //Given
         let translateService = TranslateService(session:
             URLSessionFake(data: nil, response: nil, error: nil))
         //When
         let expectation = XCTestExpectation(description: "Wait for queue change")
        translateService.getTranslation(text: "Bonjour", target: language) { result in
             guard case .failure(let error) = result else {
                 XCTFail("The translation request method with an error failed")
                 return
             }
             XCTAssertNotNil(error)
             expectation.fulfill()
         }
         wait(for: [expectation], timeout: 0.01)
     }
    
    func testGetLanguages_WhenDataIsNil_ThenShouldReturnFailedCallBack() {
        //Given
        let translateService = TranslateService(session:
            URLSessionFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
       translateService.getLanguages { result in
            guard case .failure(let error) = result else {
                XCTFail("The translation request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetTranslation_WhenResponseIsInccorect_ThenShouldReturnFailedCallBack() {
         //Given
         let translateService = TranslateService(session:
             URLSessionFake(data: FakeResponseData.exchangeCorrectData,
                            response: FakeResponseData.responseKO, error: nil))
         //When
         let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(text: "Bonjour", target: language) { result in
             guard case .failure(let error) = result else {
                 XCTFail("The translation request method with an error failed")
                 return
             }
             XCTAssertNotNil(error)
             expectation.fulfill()
         }
         wait(for: [expectation], timeout: 0.01)
     }
    
    func testGetLanguages_WhenResponseIsInccorect_ThenShouldReturnFailedCallBack() {
          //Given
          let translateService = TranslateService(session:
              URLSessionFake(data: FakeResponseData.exchangeCorrectData,
                             response: FakeResponseData.responseKO, error: nil))
          //When
          let expectation = XCTestExpectation(description: "Wait for queue change.")
         translateService.getLanguages { result in
              guard case .failure(let error) = result else {
                  XCTFail("The translation request method with an error failed")
                  return
              }
              XCTAssertNotNil(error)
              expectation.fulfill()
          }
          wait(for: [expectation], timeout: 0.01)
      }
    
    func testGetTranslation_WhenDataIsInccorect_ThenShouldReturnFailedCallBack() {
        //Given
        let translateService = TranslateService(session:
            URLSessionFake(data: FakeResponseData.exchangeIncorrectData,
                           response: FakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(text: "Bonjour", target: language) { result in
            guard case .failure(let error) = result else {
                XCTFail("The translation request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLanguages_WhenDataIsInccorect_ThenShouldReturnFailedCallBack() {
           //Given
           let translateService = TranslateService(session:
               URLSessionFake(data: FakeResponseData.exchangeIncorrectData,
                              response: FakeResponseData.responseOK, error: nil))
           //When
           let expectation = XCTestExpectation(description: "Wait for queue change.")
           translateService.getLanguages { result in
               guard case .failure(let error) = result else {
                   XCTFail("The translation request method with an error failed")
                   return
               }
               XCTAssertNotNil(error)
               expectation.fulfill()
           }
           wait(for: [expectation], timeout: 0.01)
       }
    
    func testGetTranslation_WhenCorrectDataAndResponseArePassed_ThenShouldReturnFailedCallBack() {
           //Given
           let translateService = TranslateService(session:
             URLSessionFake(data: FakeResponseData.translateCorrectData,
             response: FakeResponseData.responseOK, error: nil))
           //When
           let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(text: "Bonjour", target: language) { result in
               guard case .success(let results) = result else {
                   XCTFail("The translation request method with an error failed")
                   return
               }
               XCTAssertEqual(results.data.translations[0].translatedText, "Hello")
               expectation.fulfill()
           }
           wait(for: [expectation], timeout: 0.01)
       }
    
    func testGetLanguages_WhenCorrectDataAndResponseArePassed_ThenShouldReturnFailedCallBack() {
             //Given
             let translateService = TranslateService(session:
               URLSessionFake(data: FakeResponseData.translateLanguagesCorrectData,
               response: FakeResponseData.responseOK, error: nil))
             //When
             let expectation = XCTestExpectation(description: "Wait for queue change.")
          translateService.getLanguages { result in
                 guard case .success(let results) = result else {
                     XCTFail("The translation request method with an error failed")
                     return
                 }
            XCTAssertNotNil(results.data.languages[0].language)
                 expectation.fulfill()
             }
             wait(for: [expectation], timeout: 0.01)
         }
    
}
