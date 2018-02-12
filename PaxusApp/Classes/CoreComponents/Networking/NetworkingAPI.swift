//
//  NetworkingAPI.swift
//  OutwareApp
//
//  Created by Jithin on 8/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

import Foundation


/// HTTP request methods
///
/// - get: GET
/// - post: POST
/// - head: HEAD
/// - put: PUT
enum HTTPMethodType: String {
    case get     = "GET"
    case post    = "POST"
    case head    = "HEAD"
    case put     = "PUT"
}


class NetworkingAPI {
    
    /// API base URL
    ///
    /// - Returns: Base url as string
    class func apiBaseURL() -> String {
        //return "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        //return "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=cat"
        //return "https://swapi.co/api/people"
        return "http://microblogging.wingnity.com/JSONParsingTutorial/jsonActors"
    }
    
}
