
//
//  FeatureListServiceManager.swift
//  OutwareApp
//
//  Created by Jithin on 8/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

import Foundation
import SwiftyJSON

class FeatureListServiceManager {
    
    /// Singleton instance
    static let sharedInstance = FeatureListServiceManager()
    
    /// Method to fetch actor list from the url
    ///
    /// - Parameters:
    ///   - success: success call back handler
    ///   - failure: failure call back handler
    func fetchFeaturesFromServerCall(success: @escaping (_ result: [ActorsModel]?) -> Void, failure: @escaping (_ error: APIError?) -> Void ) {
        let serviceManager = WebserviceServerManager.sharedServerManager
        let serviceURL = NetworkingAPI.apiBaseURL()
        
        serviceManager.sendRequestToServer(apiServiceFullURL: serviceURL, parameters: nil, apiRequestType: .get, success: { (response) in
            var actorListResult = [ActorsModel]()
            for (_,subJson):(String, JSON) in response["actors"] {
                actorListResult.append(ActorsModel(resultArray: subJson))                
            }
            success(actorListResult)
        }) { (apiError) in
            failure(apiError)
        }
         
    }
    
}
