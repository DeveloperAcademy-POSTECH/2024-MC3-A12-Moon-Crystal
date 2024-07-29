//
//  CapacityCalculator.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/29/24.
//

import Foundation

class CapacityCalculator {
    @Published var totalStorage : Int64 = 0
    @Published var freeStorage : Int64 = 0
    
    init() {
        checkDeviceStorage()
        checkLeftStorage()
    }
    
    func checkDeviceStorage() {
        let fileURL = URL(filePath: "/")
        do {
            let values = try fileURL.resourceValues(forKeys: [.volumeTotalCapacityKey])
            if let capacity = values.volumeTotalCapacity {
                self.totalStorage = Int64(capacity)
            } else {
                print("❌ StorageManager/checkDeviceStorage Capacity is unavailable")
            }
        } catch {
            print("❌ StorageManager/checkDeviceStorage Error retrieving capacity: \(error.localizedDescription)")
        }
        self.totalStorage = 0
    }
    
    func checkLeftStorage() {
        let fileURL = URL(filePath: "/")
        do {
            let values = try fileURL.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey])
            if let capacity = values.volumeAvailableCapacityForImportantUsage {
                self.freeStorage = capacity
            } else {
                print("❌ StorageManager/checkLeftStorage Capacity is unavailable")
            }
        } catch {
            print("❌ StorageManager/checkLeftStorage Error retrieving capacity: \(error.localizedDescription)")
        }
        self.freeStorage = 0
    }
}