//
//  CustomURLProtocol.swift
//  urlProtocol_demo
//
//  Created by 李玉峰 on 2017/6/8.
//  Copyright © 2017年 李玉峰. All rights reserved.
//

import UIKit

class CustomURLProtocol: URLProtocol ,NSURLConnectionDataDelegate{
    var connection:NSURLConnection?
    
    open override class func canInit(with request: URLRequest) -> Bool {
        let scheme = request.url?.scheme
        if (scheme?.caseInsensitiveCompare("http") != nil) {
            if (URLProtocol.property(forKey: "CustomURLProtocol", in: request) != nil) {
                return false
            }
            return true
        }
        return false
    }
    
    open override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        print(request)
        var components = URLComponents(url: request.url!, resolvingAgainstBaseURL: true)
        var req:URLRequest? = nil
        if components?.queryItems != nil && (components?.queryItems?.contains(URLQueryItem(name: "a", value: "c")))! {
            
        }else{
            if components?.queryItems == nil {
                components?.queryItems = [URLQueryItem(name: "a", value: "c")]
            }else{
                components?.queryItems?.append(URLQueryItem(name: "a", value: "c"))
            }
        }
        req = NSMutableURLRequest(url: (components?.url)!) as URLRequest
        print(req ?? "nil")
        return req!
    }
    
    //必须实现
    override func startLoading() {
        let req:NSMutableURLRequest = self.request as! NSMutableURLRequest
        URLProtocol.setProperty("CustomURLProtocol", forKey: "CustomURLProtocol", in: req)
        self.connection = NSURLConnection(request: req as URLRequest, delegate: self)
    }
    
    override func stopLoading() {
        self.connection?.cancel()
    }
    
    //NSURLConnectionDataDelegate
    
    func connection(_ connection: NSURLConnection, didReceive response: URLResponse) {
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
    }
    
    func connection(_ connection: NSURLConnection, didReceive data: Data) {
        self.client?.urlProtocol(self, didLoad: data)
    }
    
    func connectionDidFinishLoading(_ connection: NSURLConnection) {
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
        self.client?.urlProtocol(self, didFailWithError: error)
    }
    
}
