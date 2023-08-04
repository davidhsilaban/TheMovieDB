//
//  APIHTTPRequest.swift
//  TheMovieDB
//
//  Created by David Silaban on 23/08/21.
//

import Foundation

class APIHTTPRequest {
    static let API_KEY = "02bdafe8119422f52cae64bfff62b3be"
    static let BASE_URL = "https://api.themoviedb.org/3"
    
    private func httpRequest(method: String, endpoint: String, params: [String:Any]?, jsonBody: [String:Any]?, completionHandler: @escaping (_ success: Bool, _ errorCode: Int, _ response: Data?) -> Void) {
        var urlComponents = URLComponents(string: APIHTTPRequest.BASE_URL+endpoint)
        var theParams = ["api_key": APIHTTPRequest.API_KEY as Any]
        if let pars = params {
            theParams.merge(pars) { (current, _) in current }
        }
        urlComponents?.queryItems = theParams.map { (key, value) in
            URLQueryItem(name: key, value: String(describing: value))
        }
        if let url = urlComponents?.url {
            var request = URLRequest(url: url)
            request.httpMethod = method
            if let body = jsonBody {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                let httpResponse = response as? HTTPURLResponse
                if let responseData = data {
//                    let jsonObject = try? JSONSerialization.jsonObject(with: responseData, options: [])
                    completionHandler(error == nil, httpResponse?.statusCode ?? 0, responseData)
                } else {
                    completionHandler(error == nil, httpResponse?.statusCode ?? 0, nil)
                }
            }.resume()
        }
    }
    
    func httpGet(endpoint: String, params: [String:Any]?, completionHandler: @escaping (_ success: Bool, _ errorCode: Int, _ response: Data?) -> Void) {
        httpRequest(method: "GET", endpoint: endpoint, params: params, jsonBody: nil, completionHandler: completionHandler)
    }
    
    func httpPost(endpoint: String, params: [String:Any]?, jsonBody: [String:Any], completionHandler: @escaping (_ success: Bool, _ errorCode: Int, _ response: Data?) -> Void) {
        httpRequest(method: "POST", endpoint: endpoint, params: params, jsonBody: jsonBody, completionHandler: completionHandler)
    }
}
