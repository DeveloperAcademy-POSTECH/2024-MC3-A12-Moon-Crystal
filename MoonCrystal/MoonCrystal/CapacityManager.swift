//
//  DynamicIslandManager.swift
//  MoonCrystal
//
//  Created by sungkug_apple_developer_ac on 7/26/24.
//

import Foundation
import ActivityKit
import Combine

enum viewStatus {
    case main, widget, end
}

class CapacityManager: ObservableObject {
    
    static let shared = CapacityManager()
    
    @Published var isGranted = false
    @Published var isNext = false
    @Published var viewStatus: viewStatus? = .main
    @Published var totalSpace = ""
    @Published var freeSpace = ""
    
    var currentFreeSpace: String = ""
    var isEnd = false
    private var currentID: String = ""
    private var timer: Timer?
    
    init() {
        fetchDiskSpace()
    }
    
    func fetchDiskSpace() {
        DispatchQueue.global().async {
            if let spaceInfo = self.getDiskSpaceInfo() {
                DispatchQueue.main.async {
                    self.totalSpace = spaceInfo.total
                    self.freeSpace = spaceInfo.free
                }
            }
        }
    }
    
    func updateDiskSpace() {
        DispatchQueue.global().async {
            if let spaceInfo = self.getDiskSpaceInfo() {
                self.currentFreeSpace = spaceInfo.free
            }
        }
    }
    
    private func getDiskSpaceInfo() -> (total: String, free: String)? {
        let fileURL = URL(fileURLWithPath:"/")
        do {
            let totalValue = try fileURL.resourceValues(forKeys: [.volumeTotalCapacityKey])
            let freeValues = try fileURL.resourceValues(forKeys: [.volumeAvailableCapacityForImportantUsageKey])
            
            
            if let totalCapacity = totalValue.volumeTotalCapacity, let freeCapacity = freeValues.volumeAvailableCapacityForImportantUsage {
//                print("여유공간 : \(getFreeDiskSpace(freeCapacity))")
                return (total: getFreeDiskSpace(Int64(totalCapacity)),
                        free: getFreeDiskSpace(freeCapacity))
            }
        } catch {
            print("❌ CapacityManager/getDiskSpaceInfo Error retrieving capacity: \(error.localizedDescription)")
        }
        return nil
    }
    
    func getFreeDiskSpace(_ byteCount: Int64) -> String {
        let formatter = ByteCountFormatter()
        formatter.allowedUnits = .useGB
        formatter.countStyle = .file
        formatter.includesUnit = true
        return formatter.string(fromByteCount: byteCount)
    }
    
    func startErase() {
        startLiveActivity()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            Task{
                self.updateDiskSpace()
                await self.updateDynamicActivity()
            }
        }
    }
    
    /**
     LiveActivity 생성
     */
    private func startLiveActivity() {
        if #available(iOS 16.2, *) {
            if ActivityAuthorizationInfo().areActivitiesEnabled {
                let activityData = dynamicCapacityAttributes(name: "남은용량")
                let contentState = dynamicCapacityAttributes.ContentState(capacity: currentFreeSpace)
                DispatchQueue.main.async {
                    self.currentID = LiveActivityManager.startLiveActivity(for: activityData, state: contentState)
//                    print("생성완료 \(self.currentID)")
                }
                
            }
        }
    }
    
    /**
     LiveActivity 업데이트
     */
    func updateDynamicActivity() async {
        let updatedContent = dynamicCapacityAttributes.ContentState(capacity: self.currentFreeSpace)
        DispatchQueue.main.async {
            LiveActivityManager.updateLiveActivity(for: self.currentID, contentState: updatedContent)
        }
    }
    
    /**
     LiveActivity 종료 및 제거
     */
    func endLiveActivity(contentState state:dynamicCapacityAttributes.ContentState? = nil) {
        stopTimer()
        DispatchQueue.main.async {
            LiveActivityManager.endLiveActvity(for: self.currentID)
            /*
             여기에 notification 요청문 넣으면 됩니다.(LocalNotificationManager.schedule)
             */
        }
    }
    
    private func stopTimer() {
        self.timer?.invalidate()
        self.timer = nil
        self.isEnd = true
    }
}
