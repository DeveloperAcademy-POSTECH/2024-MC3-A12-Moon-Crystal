//
//  UserDefaultMannager.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 8/4/24.
//

import Foundation


class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let totalCapacityKey = "totalCapacity"
    private let freeCapacityKey = "freeCapacity"
    private let progressKey = "progress"
    private let nameKey = "name"
    
    private init() {}
    
    var totalCapacity: Int {
        get {
            return UserDefaults.standard.integer(forKey: totalCapacityKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: totalCapacityKey)
        }
    }
    
    var freeCapacity: Int {
        get {
            return UserDefaults.standard.integer(forKey: freeCapacityKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: freeCapacityKey)
        }
    }
    
    var progress: Float {
        get {
            return UserDefaults.standard.float(forKey: progressKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: progressKey)
        }
    }
    
    var name: String {
        get {
            return UserDefaults.standard.string(forKey: nameKey) ?? "최애"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: nameKey)
        }
    }
}
