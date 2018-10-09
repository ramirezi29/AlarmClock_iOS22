//
//  AlarmVCExtension.swift
//  AlarmClock_iOS22
//
//  Created by Ivan Ramirez on 10/8/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

extension ALarmListTableViewController {
    
    func AlarmListBackGroundUI(){
        let blueMountains = UIImage(named: "blueMountainsCloud")
        let imageView = UIImageView(image: blueMountains)
        tableView.backgroundView = imageView
        imageView.contentMode = .scaleAspectFill
    }
}
