//
//  CapacityCalculator.swift
//  MoonCrystal
//
//  Created by seonu kim on 7/29/24.
//

import Foundation

final class CapacityCalculator: ObservableObject {
    @Published var totalCapacity = 0
    @Published var freeCapacity = 0
    
    init() {
        updateTotalCapacity()
        updateFreeCapacity()
    }
    
    private func updateTotalCapacity() {
        let fileURL = URL(filePath: "/")
        do {
            let values = try fileURL.resourceValues(forKeys: [.volumeTotalCapacityKey])
            if let capacity = values.volumeTotalCapacity {
                self.totalCapacity = capacity
            } else {
                print("❌ StorageManager/checkDeviceStorage Capacity is unavailable")
            }
        } catch {
            print("❌ StorageManager/checkDeviceStorage Error retrieving capacity: \(error.localizedDescription)")
        }
    }
    
    func updateFreeCapacity() {
        let fileURL = URL(filePath: "/")
        do {
            let values = try fileURL.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey])
            if let capacity = values.volumeAvailableCapacityForImportantUsage {
                self.freeCapacity = Int(capacity)
            } else {
                print("❌ StorageManager/checkLeftStorage Capacity is unavailable")
            }
        } catch {
            print("❌ StorageManager/checkLeftStorage Error retrieving capacity: \(error.localizedDescription)")
        }
    }
}
