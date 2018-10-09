//
//  SwitchTableViewCell.swift
//  AlarmClock_iOS22
//
//  Created by Ivan Ramirez on 10/8/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: class {
    func SwitchCellSwitchValueChanged(cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {
    @IBOutlet weak var alarmTime: UILabel!
    @IBOutlet weak var alarmName: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    var alarm: Alarm? {
        didSet{
            updateViews()
        }
    }
    
    weak var delegate: SwitchTableViewCellDelegate?
    
    
    func updateViews() {
        guard let alarm = alarm  else {return}
        alarmName.text = alarm.name
        alarmTime.text = alarm.fireTimeAsString
        alarmSwitch.isOn = alarm.isOn
    }
    
    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.SwitchCellSwitchValueChanged(cell: self)
    }
    
}
