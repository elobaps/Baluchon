//
//  URLSessionFake.swift
//  BaluchonTests
//
//  Created by Elodie-Anne Parquer on 05/11/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import Foundation

final class URLSessionFake: URLSession {
    var data: Data?
    var response: URLResponse?
    var error: Error?

    init(data: Data?, response: URLResponse?, error: Error?) {
        self.data = data
        self.response = response
        self.error = error
    }

    override func dataTask(with url: URL, completionHandler:
        @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake(data: data,
        urlResponse: response, responseError: error, completionHandler: completionHandler)
        task.completionHandler = completionHandler
        return task
    }
    override func dataTask(with request: URLRequest, completionHandler:
        @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSessionDataTaskFake(data: data,
        urlResponse: response, responseError: error, completionHandler: completionHandler)
        task.completionHandler = completionHandler
        return task
    }
}

final class URLSessionDataTaskFake: URLSessionDataTask {
    
    var completionHandler: ((Data?, URLResponse?, Error?) -> Void)?

    var data: Data?
    var urlResponse: URLResponse?
    var responseError: Error?
    
    init(data: Data?, urlResponse: URLResponse?, responseError: Error?,
         completionHandler: ((Data?, URLResponse?, Error?) -> Void)?) {
          self.completionHandler = completionHandler
          self.data = data
          self.urlResponse = urlResponse
          self.responseError = responseError
    }

    override func resume() {
        completionHandler?(data, urlResponse, responseError)
    }

    override func cancel() {}
}
