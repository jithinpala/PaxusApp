//
//  SWPeopleListViewController.swift
//  OutwareApp
//
//  Created by Jithin on 8/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

import UIKit


class ActorsListViewController: UIViewController {

    // MARK:- IBOutlet declaration
    @IBOutlet weak var actorListTableView: UITableView!
    @IBOutlet weak var controllerHeaderBar: UIView!
    
    // MARK:- variable declaraion
    var actorListArray =  [ActorsModel]()
    var waringLabel: UILabel!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.reloadActorListFromServer(_:)), for: .valueChanged)
        refreshControl.tintColor = UIColor.appThemeBlueColor()
        
        return refreshControl
    }()
    
    /// ViewDidLoad method
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizeAppearance()
        self.fetchActorListFromServer()
    }
    
    
    /// ViewWillApper method
    ///
    /// - Parameter animated: true or false
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }  

}


// MARK:- TableView Delegate and DataSource
extension ActorsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    /// Tableview section
    ///
    /// - Parameter tableView: UITableView
    /// - Returns: section cout as Int
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    /// Number of row in section
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - section: section number as Int
    /// - Returns: number of rows as Int
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard actorListArray.count > 0 else {
            return 0
        }
        return actorListArray.count
    }
    
    
    /// Create tableview cell and declare cell details
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - indexPath: Indexpath for the cell
    /// - Returns: UITableViewCell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActorDetailsTableViewCell") as! ActorDetailsTableViewCell
        cell.configureDataIncell(actorDetails: actorListArray[indexPath.row])
        return cell
        
    }    

    
}

// MARK:- Outlet Actions and Methods
extension ActorsListViewController {
    
    /// Filter button tap action method
    ///
    /// - Parameter sender: UIButton as sender
    @IBAction func filterButtonTapAction(sender: UIButton) {
        
    }
    
    /// To customize the UI appearance of VC
    func customizeAppearance() {
        controllerHeaderBar.backgroundColor = UIColor.appThemeBlueColor()
        self.actorListTableView.addSubview(refreshControl)
    }
    
    /// Method to show warning about nectwork connection
    func showWaringLabel() {
        waringLabel = UILabel()
        waringLabel.frame = CGRect(x: 15, y: (actorListTableView.frame.size.height / 2) - 30, width: actorListTableView.frame.size.width - 30, height: 60)
        waringLabel.backgroundColor = UIColor.clear
        waringLabel.numberOfLines = 0
        waringLabel.textColor = UIColor.black
        waringLabel.text = "Label.warning.message".localized()
        waringLabel.textAlignment = NSTextAlignment.center
        waringLabel.font = UIFont(name: "Helvetica", size: 25.0)
        self.actorListTableView.addSubview(waringLabel)
    }
    
    /// Method to remove warning
    func removeWaringFromParentView() {
        guard (waringLabel != nil) else {
            return
        }
        if self.waringLabel.isDescendant(of: self.actorListTableView) {
            self.waringLabel.removeFromSuperview()
        }
    }
    
}

// MARK:- Webservice call
extension ActorsListViewController {
    
    /// Method to fetch people list and this methos is the fisrt call
    func fetchActorListFromServer() {
        //PXProgressHUD.sharedInstance.showHUDWithMessage(message: "Progress.hud.loading".localized())
        FeatureListServiceManager.sharedInstance.fetchFeaturesFromServerCall(success: { (fetchedResult) in
            self.actorListArray = fetchedResult!
            //PXProgressHUD.sharedInstance.hideHUD()
            self.actorListTableView.reloadAnimation()
        }) { (apiError) in
            self.showWaringLabel()
            if (apiError?.errorCode)! > 0 {
                PXAlert.ShowSimpleAlertWithHandler(withMessage: (apiError?.errorString)!, inController: self, completionHandler: { (finished) in
                    
                })
            }
            PXAlert.ShowSimpleAlert(withMessage: "Alert.webservice.failure".localized(), inController: self)
        }
        
    }
    
    /// Method to fetch people details and this use as tableview loadmore call
    @objc func reloadActorListFromServer(_ refreshController: UIRefreshControl) {
        FeatureListServiceManager.sharedInstance.fetchFeaturesFromServerCall(success: { (fetchedResult) in
            self.actorListArray = fetchedResult!
            //self.actorListTableView.reloadData()
            self.actorListTableView.reloadAnimation(animationType: .fade)
            refreshController.endRefreshing()
        }) { (apiError) in
            refreshController.endRefreshing()
        }
    }
    
}



