//
//  ActorDetailsTableViewCell.swift
//  PaxusApp
//
//  Created by Jithin on 12/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

import UIKit
import AlamofireImage

class ActorDetailsTableViewCell: UITableViewCell {
    
    // MARK:- IBOutlet declaration
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var actorCountryLabel: UILabel!
    @IBOutlet weak var actorDOBLabel: UILabel!
    @IBOutlet weak var actorChildrenLabel: UILabel!
    @IBOutlet weak var actorDescriptionLabel: UILabel!
    @IBOutlet weak var actorImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureDataIncell(actorDetails: ActorsModel) {
        actorNameLabel.text = actorDetails.actorName
        actorCountryLabel.text = "Country : " + actorDetails.actorCountry!
        actorDOBLabel.text = "DOB : " + actorDetails.actorDOB!
        actorChildrenLabel.text = "Children : " + actorDetails.actorChildern!
        actorDescriptionLabel.text = actorDetails.actorDescription
        let size = actorImageView.frame.size
        actorImageView.af_setImage(withURL: URL(string: actorDetails.actorImageUrlPath!)!, placeholderImage: UIImage(named: "animationImage5"), filter: AspectScaledToFillSizeWithRoundedCornersFilter(size: size, radius: (size.width / 2)), progress: nil, progressQueue: DispatchQueue.main, imageTransition: .crossDissolve(0.2), runImageTransitionIfCached: true, completion: nil)
        
        
       //UIImage(named: "animationImage5")!
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
