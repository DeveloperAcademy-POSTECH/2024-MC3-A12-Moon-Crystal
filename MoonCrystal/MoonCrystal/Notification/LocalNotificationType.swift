//
//  LocalNotification.swift
//  MoonCrystal
//
//  Created by zaehorang on 7/26/24.
//

enum NotificationType: String {
    case refresh
    case result
    
    func content(favoritIdol: String? = nil, deletedCapacity: String? = nil, deletedTotalCapacity: String? = nil) -> (title: String, body: String) {
        switch self {
        case .refresh:
            let title = "현재 얼마나 지웠는지 확인해볼까요?"
            let body = "잠금화면에서 새로고침을 누르면 실시간 현황을 확인할 수 있어요"
            return (title, body)
            
        case .result:
            guard let favoritIdol = favoritIdol, let data = deletedCapacity, let total = deletedTotalCapacity else {
                return ("Result Notification", "지금까지 정리된 내용을 확인할 수 없습니다.")
            }
            let title = "\(data)GB 정리 완료!"
            let body = "지금까지 \(favoritIdol)를 위해 \(total)GB를 정리했어요"
            return (title, body)
        }
    }
}

struct LocalNotification {
    var type: NotificationType
    var identifier: String {
        type.rawValue
    }
    var title: String
    var body: String
    var timeInterval: Double
    var repeats: Bool
    
    /// LocalNotification 초기화 메서드
    /// - Parameters:
    ///   - type: Notification의 타입을 나타냅니다 (`refresh`, `result`).
    ///   - favoritIdol: `result` 타입일 때 사용되며, 사용자의 좋아하는 아이돌을 나타냅니다.
    ///   - deletedCapacity: `result` 타입일 때 사용되며, 정리된 데이터의 종류를 나타냅니다.
    ///   - deletedTotalCapacity: `result` 타입일 때 사용되며, 정리된 데이터의 총량을 나타냅니다.
    ///   - timeInterval: Notification이 트리거되는 시간을 설정합니다.
    ///   - repeats: Notification이 반복되는지 여부를 설정합니다.
    init(type: NotificationType, favoritIdol: String? = nil, deletedCapacity: String? = nil, deletedTotalCapacity: String? = nil, timeInterval: Double, repeats: Bool = false) {
        self.type = type
        self.timeInterval = timeInterval
        self.repeats = repeats
        
        // NotificationType에 따라 제목과 설명을 설정합니다.
        let content = type.content(favoritIdol: favoritIdol, deletedCapacity: deletedCapacity, deletedTotalCapacity: deletedTotalCapacity)
        self.title = content.title
        self.body = content.body
    }
}
