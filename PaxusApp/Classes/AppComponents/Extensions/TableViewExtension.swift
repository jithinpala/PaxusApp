//
//  TableViewExtension.swift
//  PaxusApp
//
//  Created by Jithin on 12/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func reloadAnimation(animationType: UITableViewRowAnimation = .automatic) {
        let range = NSMakeRange(0, self.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        self.reloadSections(sections as IndexSet, with: .automatic)
    }
}
