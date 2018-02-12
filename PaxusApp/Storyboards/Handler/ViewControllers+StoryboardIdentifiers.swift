//
//  ViewControllers+StoryboardIdentifiers.swift
//  OutwareApp
//
//  Created by Jithin on 8/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

import Foundation
import UIKit

extension ActorsListViewController: StoryboardIdentifiable {
    
    class func getController() -> ActorsListViewController {
        return ActorsListViewController.instantiateViewControllerFromStoryboard(UIStoryboard.homeStoryboard()) as! ActorsListViewController
    }
    
    class func storyboardIdentifier() -> String {
        return "CountryDetailsViewController"
    }
    
}

//extension FilterViewController: StoryboardIdentifiable {
//    
//    class func getController() -> FilterViewController {
//        return FilterViewController.instantiateViewControllerFromStoryboard(UIStoryboard.homeStoryboard()) as! FilterViewController
//    }
//    
//    class func storyboardIdentifier() -> String {
//        return "FilterViewController"
//    }
//    
//}

