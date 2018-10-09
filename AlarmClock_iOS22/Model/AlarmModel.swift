//
//  AlarmModel.swift
//  AlarmClock_iOS22
//
//  Created by Ivan Ramirez on 10/8/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation

class Alarm {
    var fireDate: Date
    var name: String
    var isOn: Bool
    let uuid: String
    
    init(fireDate: Date, name: String, isOn: Bool = true, uuid: String = UUID().uuidString) {
        self.fireDate = fireDate
        self.name = name
        self.uuid = uuid
        self.isOn = isOn
    }
    
    var fireTimeAsString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: fireDate)
    }
}

extension Alarm: Equatable {
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        if lhs.uuid != rhs.uuid {return false }
        return true
    }
    
    
}
