//
//  IcuHeartbeatManager.swift
//  ICU996
//
//  Created by Harry Duan on 2019/4/3.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit
import CocoaLumberjack

class IcuHeartbeatManager: NSObject {
    static let shared = IcuHeartbeatManager()
    
    private var timer: DispatchSourceTimer?
    
    override init() {
        super.init()
    }

    /// 开始心跳
    public func startTimer() {
        timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer?.schedule(deadline: .now() + .seconds(10),
                        repeating: DispatchTimeInterval.seconds(1))
        timer?.setEventHandler {
            // Notification for refresh
            NotificationCenter.default.post(name: .HeartbeatRefresh, object: nil)
        }
        timer?.resume()
    }
    
    /// 暂停心跳
    public func stopTimer() {
        timer?.suspend()
    }

    /// 销毁心跳
    public func cancelTimer() {
        guard let t = timer else {
            DDLogDebug("已经销毁，无需 cancel")
            return
        }
        t.cancel()
        timer = nil
    }
    
}
