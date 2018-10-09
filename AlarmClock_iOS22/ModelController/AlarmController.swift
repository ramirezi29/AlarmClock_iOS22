//
//  ModelController.swift
//  AlarmClock_iOS22
//
//  Created by Ivan Ramirez on 10/8/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation

class AlarmController {
    
    // singleton
    static let shared = AlarmController()
    
    //source of verdad
    var alarms: [Alarm] = []
    
    // Create
    func addAlarm(fireDate: Date, name: String, isOn: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, name: name)
        newAlarm.isOn = isOn
        alarms.append(newAlarm)
    }
    
    func update(alarm: Alarm, fireDate: Date, name: String, isOn: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.isOn = isOn
        
    }
    
    func delete(alarm: Alarm){
      guard let index = alarms.index(of: alarm)  else {return}
        alarms.remove(at: index)
    }
    
    func toggleEnabled(for alarm: Alarm) {
         alarm.isOn = !alarm.isOn
        }
    }



