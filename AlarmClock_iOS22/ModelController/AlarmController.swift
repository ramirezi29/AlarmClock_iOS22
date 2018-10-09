//
//  ModelController.swift
//  AlarmClock_iOS22
//
//  Created by Ivan Ramirez on 10/8/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: class {
    func scheduleUserNotifications(for alarm: Alarm)
    
    func cancelUserNotifications(for alarm: Alarm)
}

class AlarmController {
    
    // singleton
    static let shared = AlarmController()
    
    //source of verdad
    var alarms: [Alarm] = []
    
    init(){
        loadFromPersistentStore()
    }
    
    // Create
    func addAlarm(fireDate: Date, name: String, isOn: Bool) {
        let newAlarm = Alarm(fireDate: fireDate, name: name)
        newAlarm.isOn = isOn
        alarms.append(newAlarm)
        scheduleUserNotifications(for: newAlarm)
        saveToPersistentStorage()
    }
    
    func update(alarm: Alarm, fireDate: Date, name: String, isOn: Bool) {
        cancelUserNotifications(for: alarm)
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.isOn = isOn
        scheduleUserNotifications(for: alarm)
        saveToPersistentStorage()
    }
    
    func delete(alarm: Alarm){
        guard let index = alarms.index(of: alarm)  else {return}
        alarms.remove(at: index)
        self.cancelUserNotifications(for: alarm)
        saveToPersistentStorage()
    }
    
    func toggleEnabled(for alarm: Alarm) {
        alarm.isOn = !alarm.isOn
        if alarm.isOn {
            scheduleUserNotifications(for: alarm)
        } else {
            cancelUserNotifications(for: alarm)
        }
    }
}

extension AlarmController {
    // MARK: Persistence
    
    private static func filePath() -> URL {
        let fileManger = FileManager.default
        let paths = fileManger.urls(for: .documentDirectory, in: .userDomainMask)
        guard let path = paths.first else {fatalError("BadPath")}
        let url = path.appendingPathComponent("alarm.json")
        return url
    }
    
    // Save Persistent
    func saveToPersistentStorage() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(alarms)
            print(data)
            print(String(data: data, encoding: .utf8)!)
            // it said i had to put alarmController.filePath() due to it being static
            try data.write(to: AlarmController.filePath())
        } catch let error {
            print("🚀 There was an error in \(#function); \(error); \(error.localizedDescription) 🚀")
        }
    }
    
    
    // Load Persistent
    func loadFromPersistentStore() {
        let decoder = JSONDecoder()
        do { // added Alarmcontroller.filePath. could be wrong
            let data = try Data(contentsOf: AlarmController.filePath())
            let alarms = try decoder.decode([Alarm].self, from: data)
            self.alarms = alarms
        } catch let error {
            print("🚀 There was an error in \(#function); \(error); \(error.localizedDescription) 🚀")
        }
    }
}

extension AlarmController: AlarmScheduler{
    
    
    enum identifierKeys: String {
        case actionKey = "Get_UP"
        case catagoryKey = "Sleep"
        case requestKey = "Open_UP"
    }
    
    //create default implementations for the two protocol functions
    func scheduleUserNotifications(for alarm: Alarm) {
        
        // MARK: - UNNotificationAction
        // "\(identifierKeys.actionKey.rawValue, terminator: "")"
        let action = UNNotificationAction(identifier: "Get_UP", title: "I'm Ready to get UP!", options: [])
        let category = UNNotificationCategory(identifier: "Sleep", actions: [action], intentIdentifiers: [], options: [.customDismissAction])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        // MARK: - UNMutableNotificationContent
        let content = UNMutableNotificationContent()
        content.title = "It's Time to Get Up!!"
        // NOTE: - I wonder waht this code below does
        // content.launchImageName()
        content.subtitle = "\(alarm.name) just went off"
        content.body = "The Wait is over"
        content.sound = UNNotificationSound.default
        content.badge = 100
        content.categoryIdentifier = "now"
        
        // MARK: - Trigger
        let components = Calendar.current.dateComponents([.hour, .minute, .second], from: alarm.fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "Open_Up", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("🚀 There was an error in \(#function); \(error); \(error.localizedDescription) 🚀")
            }
        }
    }
    
    //function simply needs to remove pending notification requests using 
    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
}
