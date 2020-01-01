//
//  WeatherServiceTestCase.swift
//  BaluchonTests
//
//  Created by Elodie-Anne Parquer on 14/11/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

@testable import Baluchon
import XCTest

class WeatherServiceTestCase: XCTestCase {
    
    func testGetWeather_WhenErrorIsOccured_ThenShouldReturnFailedCallBack() {
        //Given
        let weatherService = WeatherService(session:
            URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather { result in
            guard case .failure(let error) = result else {
                XCTFail("The rate recovery request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeather_WhenDataIsNil_ThenShouldReturnFailedCallBack() {
        //Given
        let weatherService = WeatherService(session:
            URLSessionFake(data: nil, response: nil, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        weatherService.getWeather { result in
            guard case .failure(let error) = result else {
                XCTFail("The weather request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeather_WhenResponseIsInccorect_ThenShouldReturnFailedCallBack() {
        //Given
        let weatherService = WeatherService(session:
            URLSessionFake(data: FakeResponseData.exchangeCorrectData,
                           response: FakeResponseData.responseKO, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { result in
            guard case .failure(let error) = result else {
                XCTFail("The weather request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeather_WhenDataIsInccorect_ThenShouldReturnFailedCallBack() {
        //Given
        let weatherService = WeatherService(session:
            URLSessionFake(data: FakeResponseData.exchangeIncorrectData,
                           response: FakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { result in
            guard case .failure(let error) = result else {
                XCTFail("The weather request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetWeather_WhenCorrectDataAndResponseArePassed_ThenShouldReturnFailedCallBack() {
        //Given
        let weatherService = WeatherService(session:
            URLSessionFake(data: FakeResponseData.weatherCorrectData,
                           response: FakeResponseData.responseOK, error: nil))
        //When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather { result in
            guard case .success(let results) = result else {
                XCTFail("The weather request method with an error failed")
                return
            }
            XCTAssertNotNil(results.list[0].main.temp)
            XCTAssertNotNil(results.list[1].main.temp)
            XCTAssertEqual(results.list[0].weather[0].weatherDescription, "couvert")
            XCTAssertEqual(results.list[1].weather[0].weatherDescription, "légère pluie")
            XCTAssertNotNil(results.list[0].weather[0].icon)
            XCTAssertNotNil(results.list[1].weather[0].icon)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}
