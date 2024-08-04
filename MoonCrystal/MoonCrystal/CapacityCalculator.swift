//
//  CapacityCalculator.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/29/24.
//

import Foundation

final class CapacityCalculator {
    // liveActivityMannager 내에서도 사용해야돼서 obsevableObject는 제거했습니다
    static func getTotalCapacity() async -> Int {
        let fileURL = URL(filePath: "/")
        do {
            let values = try fileURL.resourceValues(forKeys: [.volumeTotalCapacityKey])
            if let capacity = values.volumeTotalCapacity {
                return capacity
            } else {
                print("❌ StorageManager/checkDeviceStorage Capacity is unavailable")
                return 0
            }
        } catch {
            print("❌ StorageManager/checkDeviceStorage Error retrieving capacity: \(error.localizedDescription)")
            return 0
        }
    }
    
    static func getFreeCapacity() async -> Int {
        let fileURL = URL(filePath: "/")
        do {
            let values = try fileURL.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey])
            if let capacity = values.volumeAvailableCapacityForImportantUsage {
                return Int(capacity)
            } else {
                print("❌ StorageManager/checkLeftStorage Capacity is unavailable")
                return 0
            }
        } catch {
            print("❌ StorageManager/checkLeftStorage Error retrieving capacity: \(error.localizedDescription)")
            return 0
        }
    }
    
    static func getCleanUpFreeCapacity() async -> Int {
        let preFreeCapacity = UserDefaults.standard.integer(forKey: "preFreeCapacity")
        let currentFreeCapacity = await getFreeCapacity()
        let deletedCapacity = currentFreeCapacity - preFreeCapacity
        
        if deletedCapacity > 0 {
            return deletedCapacity
        }
        
        return 0
    }
}
