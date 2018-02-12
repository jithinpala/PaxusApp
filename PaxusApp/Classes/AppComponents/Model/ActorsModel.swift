//
//  ActorsModel.swift
//  PaxusApp
//
//  Created by Jithin on 12/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

import UIKit
import UIKit
import SwiftyJSON

class ActorsModel: NSObject {
    
    var actorName: String?
    var actorDOB: String?
    var actorCountry: String?
    var actorChildern: String?
    var actorImageUrlPath: String?
    var actorDescription: String?
    
    override init() {
        super.init()
    }
    
    /// Initialization method using json data
    ///
    /// - Parameter resultArray: PeopleList object
    init(resultArray: JSON) {
        super.init()
        self.actorName = resultArray["name"].stringValue
        self.actorDOB = resultArray["dob"].stringValue
        self.actorCountry = resultArray["country"].stringValue
        self.actorChildern = resultArray["children"].stringValue
        self.actorImageUrlPath = resultArray["image"].stringValue
        self.actorDescription = resultArray["description"].stringValue        
        
        //self.featureTitle = resultArray["title"].stringValue
        //self.featureImageUrlPath = resultArray["description"].stringValue
        //self.featureDescription = resultArray["imageHref"].stringValue
        
    }

}
