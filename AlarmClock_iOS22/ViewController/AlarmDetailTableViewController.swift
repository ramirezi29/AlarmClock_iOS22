//
//  AlarmDetailTableViewController.swift
//  AlarmClock_iOS22
//
//  Created by Ivan Ramirez on 10/8/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    
    @IBOutlet weak var alarmNameTextField: UITextField!
    @IBOutlet weak var enableDisableButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var alarmIsOn: Bool = false
    
    var alarm: Alarm?{
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EnableButtonUI()
        DetailBackGroundUI()
    }
    
    private func updateViews() {
        guard let alarm = alarm else {return}
        datePicker.date = alarm.fireDate
        alarmIsOn = alarm.isOn
        alarmNameTextField.text = alarm.name
        EnableButtonChanged()
    }
    
    func EnableButtonChanged(){
        switch alarmIsOn {
        case true:
            enableDisableButton.backgroundColor = UIColor.cyan
            enableDisableButton.setTitle("On", for: .normal)
        case false:
            enableDisableButton.backgroundColor = UIColor.clear
            enableDisableButton.setTitle("Off", for: .normal)
        }
    }
    
    
    @IBAction func enableDisabledTapped(_ sender: Any) {
        print("Enable Button CLicked")
        if let alarm = alarm {
            AlarmController.shared.toggleEnabled(for: alarm)
            alarmIsOn = alarm.isOn
        } else {
            alarmIsOn = !alarmIsOn
        }
        EnableButtonChanged()
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = alarmNameTextField.text else {return}
        guard !name.isEmpty else {return}
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, fireDate: datePicker.date, name: name, isOn: alarmIsOn)
        } else {
             AlarmController.shared.addAlarm(fireDate: datePicker.date, name: name, isOn: alarmIsOn)
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension AlarmDetailTableViewController {
    
    // MARK: TableView UI
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        cell.backgroundColor = UIColor(white: 0, alpha: 0.0)
        alarmNameTextField.backgroundColor = UIColor(white: 0, alpha: 0.0)
        alarmNameTextField.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
    }
}


