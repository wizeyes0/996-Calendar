//
//  AppDelegate.swift
//  ICU996
//
//  Created by Harry Duan on 2019/3/28.
//  Copyright © 2019 Harry Duan. All rights reserved.
//

import UIKit
import DLLocalNotifications
import UserNotifications
import CocoaLumberjack

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //请求通知权限
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound]) { (has, error) in
            
        }
        
        // 每天固定早上9点、晚上22：00发出通知
        let dayNotification = DLNotification(identifier: "dayNotification", alertTitle: "今天996了吗？", alertBody: ICUSaying.Positive.a.rawValue, date: Date(timeIntervalSince1970: 1*60*60) , repeats: .daily)
        
        let nightNotification = DLNotification(identifier: "nightNotification", alertTitle: "今天996了吗？", alertBody: ICUSaying.Negative.e.rawValue, date: Date(timeIntervalSince1970: 14*60*60) , repeats: .daily)
        
        //添加到系统通知中
        let scheduler = DLNotificationScheduler()
        scheduler.scheduleNotification(notification: dayNotification)
        scheduler.scheduleNotification(notification: nightNotification)
        scheduler.scheduleAllNotifications()
        
        // Register
        registerCocoaLumberjack()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    private func registerCocoaLumberjack() {
        DDLog.add(DDOSLogger.sharedInstance) // Uses os_log
        
        let fileLogger: DDFileLogger = DDFileLogger() // File Logger
        fileLogger.rollingFrequency = 60 * 60 * 24 // 24 hours
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7
        DDLog.add(fileLogger)
    }

}

