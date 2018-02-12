//
//  WebserviceServerManager.swift
//  OutwareApp
//
//  Created by Jithin on 8/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WebserviceServerManager {
    static var sharedServerManager = WebserviceServerManager()
    
    /// Check network connection availability
    fileprivate var isReachable: Bool {
        if let reachability =  Reachability()?.currentReachabilityStatus{
            return reachability != .notReachable
        }
        return false
    }
    
    /*
    func sendRequestToServerWithNativeRequest(apiServiceFullURL: String, parameters: [String : AnyObject]?, apiRequestType: HTTPMethodType, success: @escaping (_ responseData: JSON) -> Void, failure: @escaping (_ error: APIError?) -> Void) {
        
        guard isReachable else {
            failure(APIError(errCode: 503, errString: "Alert.webservice.failure".localized(), err: nil))
            return
        }
        
        guard let url = URL(string: apiServiceFullURL) else {
            failure(APIError(errCode: 503, errString: "Alert.webservice.failure".localized(), err: nil))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        let dataTask = session.dataTask(with: urlRequest) { (fetchedData, urlResponse, error) in
            
            print("Data bytes return => \(fetchedData)")
            
            guard error == nil else {
                print("returning error")
                return
            }
            
            guard let content = fetchedData else {
                print("not returning data")
                return
            }
            
            do {
                //var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                var strData = String(data: content, encoding: .utf8)
                //let parsedJDON = try JSONSerialization.jsonObject(with: fetchedData!, options: .allowFragments)
                var dataString = String(data: content, encoding: String.Encoding.utf8)
                //print(dataString)
                //dataString = dataString.replacingOccurrences(of: "\\", with: "'")
                //stringByReplacingOccurrencesOfString("\\'", withString: "'")
                //let cleanData: Data = dataString.data(using: String.Encoding.utf8)!
                //let parsedJDON = try JSONSerialization.jsonObject(with: content, options: []) as! [String:AnyObject]
                let parsedJDON = try JSONSerialization.jsonObject(with: fetchedData!, options: .mutableContainers)
                  print(parsedJDON)
                } catch let error{
                    print("json error: \(error.localizedDescription)")
                }
            let jsonSwifty = JSON(data: fetchedData!)
            success(jsonSwifty)
                
            }
           
            dataTask.resume()
        
    }
        
    */
        
    
    
    
    
    /// Method to interact with server
    ///
    /// - Parameters:
    ///   - apiServiceFullURL: Full URL path as String
    ///   - parameters: Param to server
    ///   - apiRequestType: API request type
    ///   - success: success call back handler
    ///   - failure: failure call back handler
    func sendRequestToServer(apiServiceFullURL: String, parameters: [String : AnyObject]?, apiRequestType: HTTPMethodType, success: @escaping (_ responseData: JSON) -> Void, failure: @escaping (_ error: APIError?) -> Void) {
        
        guard isReachable else {
            failure(APIError(errCode: 503, errString: "Alert.webservice.failure".localized(), err: nil))
            return
        }
        let httpMethod = getHttpRequestType(apiRequestType: apiRequestType)
        let parameterEncoding:ParameterEncoding
        if(apiRequestType == HTTPMethodType.post) {
            parameterEncoding = JSONEncoding.default
        }
        else {
            parameterEncoding = URLEncoding.default
        }
        var headers:HTTPHeaders?
        /*
        var headers: HTTPHeaders = [
            "Content-Type":"application/javascript",
            "Accept": "application/javascript"
        ]
         */
        
        Alamofire.request(apiServiceFullURL,
                          method: httpMethod,
                          parameters: parameters != nil ? parameters! : nil,
                          encoding: parameterEncoding,
                          headers: headers).responseJSON { (response: DataResponse<Any>) in
                            
                            switch response.result {
                            case .failure(let error):
                                print(error.localizedDescription)
                                if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                                    print(responseString) // Print error data
                                }
                                failure(APIError(err: error))
                                return
                            case .success(let responseObject):                                
                                guard let jsonData = responseObject as? [String: AnyObject]
                                    else {
                                        /// No response data from server
                                        let anErr : APIError = APIError(errCode: 1, errString: "No response data.", err: nil)
                                        failure(anErr)
                                        return
                                }
                                let jsonSwifty = JSON(data: response.data!)
                                success(jsonSwifty)
                                return
                            }
        }
        
    }
    
    
    /// To get HTTPMethod request type
    ///
    /// - parameter apiRequestType: api request type
    ///
    /// - returns: HTTPMethod
    private func getHttpRequestType(apiRequestType: HTTPMethodType) -> (HTTPMethod) {
        
        switch apiRequestType {
        case .get:
            return HTTPMethod.get
        case .post:
            return HTTPMethod.post
        case .head:
            return HTTPMethod.head
        case .put:
            return HTTPMethod.put
        }
    }
    
}
