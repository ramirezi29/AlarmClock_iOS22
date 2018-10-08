//
//  SwitchTableViewCell.swift
//  AlarmClock_iOS22
//
//  Created by Ivan Ramirez on 10/8/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    @IBOutlet weak var alarmTime: UILabel!
    @IBOutlet weak var alarmName: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
    }
    
}
