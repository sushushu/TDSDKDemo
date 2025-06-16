//
//  AppDelegate.swift
//  SDKDemo
//
//  Created by softlipa on 2025/6/11.
//

import UIKit
import IAnalyticsSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 注册SDK
        AnalyticsSDK.shared.initialize(
            apiKey: "123456",                // 【必传】服务端分配的API密钥
            clientId: "woniu",             // 【必传】客户端唯一标识
            aesSecret: "YourPresharedSecretKey123456789012",             // 【必传】数据加密密钥
            apiUrl: "http://dev01-w2a.tec-develop.cn/ted-w2a-track",    // 【必传】事件上报API地址
            debugMode: true,                      // 【选传】是否开启调试日志，默认false
            environment: "DEVELOPMENT",           // 【选传】环境配置，"PRODUCTION"或"DEVELOPMENT"，默认"PRODUCTION"
            enableAdaptiveThrottling: true,       // 【选传】是否启用自适应批量调整，默认true
            initialUploadThreshold: 20,           // 【选传】初始上传阈值，默认20
            initialUploadInterval: 60000          // 【选传】初始上传间隔（毫秒），默认60000
        )
        
//        // 1. 上报自定义事件（可带参数）
//        AnalyticsSDK.shared.trackEvent("login_success", params: ["method": "wechat"])
//
//        // 2. 上报页面访问事件
//        AnalyticsSDK.shared.trackPage("HomePage", params: ["from": "splash"])
//
//        // 3. 设置用户ID（如有用户体系建议在登录后设置）
//        AnalyticsSDK.shared.setUserId("user_123456")
//
//        // 4. 设置单个用户属性
//        AnalyticsSDK.shared.setUserProperty("vip_level", value: 3)
//        AnalyticsSDK.shared.setUserProperty("platform", value: "iOS")
//
//        // 5. 批量设置用户属性
//        AnalyticsSDK.shared.setUserProperties([
//            "gender": "male",
//            "age": 28
//        ])
//
//        // 6. 清除单个用户属性
//        AnalyticsSDK.shared.clearUserProperty("vip_level")
//
//        // 7. 清除所有用户属性
//        AnalyticsSDK.shared.clearAllUserProperties()
//
//        // 8. 设置设备属性（如自定义设备标识、分组等）
//        AnalyticsSDK.shared.setDeviceProperty("device_mock_id", value: "1234567890")
//        AnalyticsSDK.shared.setDeviceProperty("custom_tag", value: "A组")
//
//        // 9. 清除单个设备属性
//        AnalyticsSDK.shared.clearDeviceProperty("device_mock_id")
//
//        // 10. 设置 UA（User-Agent），如需自定义上报
//        AnalyticsSDK.shared.setUserAgent("MyApp/1.0.0 (iPhone; iOS 17.0)")
//
//        // 11. 设置 UTM 广告参数（如有广告投放/渠道追踪需求）
//        AnalyticsSDK.shared.setUtmParams([
//            "utm_source": "demo",
//            "utm_medium": "test",
//            "utm_campaign": "register"
//        ])
//
//        // 12. 上报用户注册事件（带UTM参数）
//        AnalyticsSDK.shared.trackRegisterEvent(utmParams: [
//            "utm_source": "demo",
//            "utm_medium": "test",
//            "utm_campaign": "register"
//        ])
//
//        // 13. 上报用户充值事件
//        AnalyticsSDK.shared.trackRechargeEvent(amount: 99.99, utmParams: [
//            "utm_source": "demo",
//            "utm_medium": "test",
//            "utm_campaign": "recharge"
//        ])
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        AnalyticsSDK.shared.handleOpenURL(url, options: options)
        return true
    }

}

