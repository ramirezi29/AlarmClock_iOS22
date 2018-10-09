//
//  DetailVCExtention.swift
//  AlarmClock_iOS22
//
//  Created by Ivan Ramirez on 10/8/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

extension AlarmDetailTableViewController {
    func EnableButtonUI() {
        enableDisableButton.layer.borderWidth = 4
        enableDisableButton.layer.borderColor = UIColor.cyan.cgColor
        enableDisableButton.layer.cornerRadius = enableDisableButton.frame.height / 4
    }
    
    func DetailBackGroundUI(){
        let blueMountains = UIImage(named: "blueMountainsCloud")
        let imageView = UIImageView(image: blueMountains)
        tableView.backgroundView = imageView
        imageView.contentMode = .scaleAspectFill
    }
}
