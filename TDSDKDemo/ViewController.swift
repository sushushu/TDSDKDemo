//
//  ViewController.swift
//  TecdoSDK
//
//  Created by softlipa on 2025/5/27.
//

import UIKit
import IAnalyticsSDK
import CryptoKit

class ViewController: UIViewController {

    private let logTextView = UITextView()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        print("DEMO-Documents Directory: \(documentsDirectory.path)")
        
        // 注册深度链接回调
        AnalyticsSDK.shared.registerDeepLinkHandlerObjC { url, params in
            print("[Demo] 收到深度链接: \(url.absoluteString ?? ""), 参数: \(params)")
            // 这里可以根据参数做业务处理
        }
    }

    // MARK: - UI搭建
    private func setupUI() {
        view.backgroundColor = .systemBackground

        // 配置logTextView
        logTextView.isEditable = false
        logTextView.font = UIFont.monospacedSystemFont(ofSize: 13, weight: .regular)
        logTextView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        logTextView.textColor = .black
        logTextView.text = "日志输出：\n"
        logTextView.isScrollEnabled = true
        logTextView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logTextView)

        // 配置scrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        // 配置stackView
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)

        // 添加测试按钮
        addTestButton(title: "测试设备信息", action: #selector(testDeviceInfo))
        addTestButton(title: "测试应用信息", action: #selector(testAppInfo))
        addTestButton(title: "测试系统信息", action: #selector(testSystemInfo))
        addTestButton(title: "获取首次安装时间", action: #selector(testFirstInstallTime))
        addTestButton(title: "重置首次安装状态", action: #selector(testResetFirstInstall))
        // 新增测试按钮
        addTestButton(title: "设置用户ID", action: #selector(testSetUserId))
        addTestButton(title: "获取用户ID", action: #selector(testGetUserId))
        addTestButton(title: "清除用户ID", action: #selector(testClearUserId))
        addTestButton(title: "设置用户属性", action: #selector(testSetUserProperty))
        addTestButton(title: "批量设置用户属性", action: #selector(testSetUserProperties))
        addTestButton(title: "获取所有用户属性", action: #selector(testGetAllUserProperties))
        addTestButton(title: "清除所有用户属性", action: #selector(testClearAllUserProperties))
        addTestButton(title: "上报自定义事件", action: #selector(testTrackEvent))
        addTestButton(title: "上报页面访问", action: #selector(testTrackPage))
        addTestButton(title: "获取事件队列", action: #selector(testGetEventQueue))
        addTestButton(title: "清空事件队列", action: #selector(testClearEventQueue))
        addTestButton(title: "获取事件队列大小", action: #selector(testGetEventQueueSize))
        addTestButton(title: "获取剪贴板参数", action: #selector(testGetClipboardParams))
        addTestButton(title: "清除剪贴板参数", action: #selector(testClearClipboardParams))
        addTestButton(title: "获取剪贴板权限状态", action: #selector(testGetClipboardPermissionStatus))
        addTestButton(title: "获取当前环境", action: #selector(testGetEnvironment))
        addTestButton(title: "设置开发环境", action: #selector(testSetDevelopmentEnv))
        addTestButton(title: "设置生产环境", action: #selector(testSetProductionEnv))
        addTestButton(title: "获取API BaseUrl", action: #selector(testGetApiBaseUrl))
        addTestButton(title: "设置API版本", action: #selector(testSetApiVersion))
        // 分享日志按钮
        addTestButton(title: "分享日志文件", action: #selector(shareLogFile))
        // 测试事件上传接口按钮
        addTestButton(title: "测试事件上传接口", action: #selector(testEventUploadAPI))
        addTestButton(title: "上报用户注册事件", action: #selector(testTrackRegisterEvent))
        addTestButton(title: "上报用户充值事件", action: #selector(testTrackRechargeEvent))
        addTestButton(title: "上报首次初始化事件", action: #selector(testTrackFirstLaunchEvent))
        addTestButton(title: "新增用户属性UserProperty", action: #selector(testAddUserProperty))
        addTestButton(title: "删除最后一个用户属性UserProperty", action: #selector(testRemoveLastUserProperty))
        addTestButton(title: "新增设备属性DeviceProperty", action: #selector(testAddDeviceProperty))
        addTestButton(title: "删除最后一个设备属性DeviceProperty", action: #selector(testRemoveLastDeviceProperty))
        addTestButton(title: "显示所有设备属性DeviceProperty", action: #selector(testShowAllDeviceProperties))
        addTestButton(title: "显示用户/UA/UTM信息", action: #selector(testShowUserUaUtmInfo))
        addTestButton(title: "获取UA", action: #selector(testGetUserAgent))

        // 约束
        NSLayoutConstraint.activate([
            // logTextView顶部、左右、固定高度
            logTextView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            logTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            logTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            logTextView.heightAnchor.constraint(equalToConstant: 260),

            // scrollView在logTextView下方，左右、底部
            scrollView.topAnchor.constraint(equalTo: logTextView.bottomAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            // stackView在scrollView内部，左右、顶部、底部，宽度等于scrollView
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
    }

    private func addTestButton(title: String, action: Selector) {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
        button.addTarget(self, action: action, for: .touchUpInside)
        stackView.addArrangedSubview(button)
    }

    // MARK: - 日志追加
    private func appendLog(_ text: String) {
        DispatchQueue.main.async {
            self.logTextView.text.append("\n\(text)")
            let range = NSRange(location: self.logTextView.text.count - 1, length: 1)
            self.logTextView.scrollRangeToVisible(range)
            print(text)
        }
    }

    // MARK: - 测试方法
    @objc private func testDeviceInfo() {
        let deviceInfo = AnalyticsSDK.shared.getDeviceInfo()
        appendLog("【设备信息】\n\(deviceInfo)")
    }

    @objc private func testAppInfo() {
        let appInfo = AnalyticsSDK.shared.getAppInfo()
        appendLog("【应用信息】\n\(appInfo)")
    }

    @objc private func testSystemInfo() {
        let networkStatus = AnalyticsSDK.shared.getNetworkStatus()
        let cpuInfo = AnalyticsSDK.shared.getCPUInfo()
        let memoryInfo = AnalyticsSDK.shared.getMemoryInfo()
        let screenInfo = AnalyticsSDK.shared.getScreenInfo()
        appendLog("""
        【系统信息】
        网络状态: \(networkStatus)
        CPU信息: \(cpuInfo)
        内存信息: \(memoryInfo)
        屏幕信息: \(screenInfo)
        """)
    }

    @objc private func testFirstInstallTime() {
        if let date = AnalyticsSDK.shared.getFirstInstallTime() {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            appendLog("【首次安装时间】\(formatter.string(from: date))")
        } else {
            appendLog("【首次安装时间】未获取到")
        }
    }

    @objc private func testResetFirstInstall() {
        AnalyticsSDK.shared.resetFirstInstallStatus()
        appendLog("【操作】已重置首次安装状态")
    }

    // MARK: - 新增测试方法
    @objc private func testSetUserId() {
        AnalyticsSDK.shared.setUserId("user_123456")
        appendLog("【操作】设置用户ID: user_123456")
    }
    @objc private func testGetUserId() {
        let userId = AnalyticsSDK.shared.getUserId() ?? "nil"
        appendLog("【用户ID】\(userId)")
    }
    @objc private func testClearUserId() {
        AnalyticsSDK.shared.clearUserId()
        appendLog("【操作】清除用户ID")
    }
    @objc private func testSetUserProperty() {
        AnalyticsSDK.shared.setUserProperty("vip_level", value: 3)
        appendLog("【操作】设置用户属性 vip_level: 3")
    }
    @objc private func testSetUserProperties() {
        let props = ["age": 28, "gender": "male"] as [String : Any]
        AnalyticsSDK.shared.setUserProperties(props)
        appendLog("【操作】批量设置用户属性: \(props)")
    }
    @objc private func testGetAllUserProperties() {
        let props = AnalyticsSDK.shared.getAllUserProperties()
        appendLog("【所有用户属性】\(props)")
    }
    @objc private func testClearAllUserProperties() {
        AnalyticsSDK.shared.clearAllUserProperties()
        appendLog("【操作】清除所有用户属性")
    }
    @objc private func testTrackEvent() {
        AnalyticsSDK.shared.trackEvent("login_success", params: ["method": "wechat"])
        appendLog("【操作】上报自定义事件 login_success")
    }
    @objc private func testTrackPage() {
        AnalyticsSDK.shared.trackPage("HomePage", params: ["from": "demo"])
        appendLog("【操作】上报页面访问 HomePage")
    }
    @objc private func testGetEventQueue() {
        let queue = AnalyticsSDK.shared.getEventQueue()
        appendLog("【事件队列】\(queue)")
    }
    @objc private func testClearEventQueue() {
        AnalyticsSDK.shared.clearEventQueue()
        appendLog("【操作】清空事件队列")
    }
    @objc private func testGetEventQueueSize() {
        let size = AnalyticsSDK.shared.getEventQueueSize()
        appendLog("【事件队列大小】\(size)")
    }
    @objc private func testGetClipboardParams() {
        let params = AnalyticsSDK.shared.getClipboardParams()
        appendLog("【剪贴板参数】\(params)")
    }
    @objc private func testClearClipboardParams() {
        AnalyticsSDK.shared.clearClipboardParams()
        appendLog("【操作】清除剪贴板参数")
    }
    @objc private func testGetClipboardPermissionStatus() {
        let status = AnalyticsSDK.shared.getClipboardPermissionStatus()
        appendLog("【剪贴板权限状态】\(status)")
    }
    @objc private func testGetEnvironment() {
        let env = AnalyticsSDK.shared.getEnvironmentString()
        appendLog("【当前环境】\(env)")
    }
    @objc private func testSetDevelopmentEnv() {
        AnalyticsSDK.shared.setEnvironmentWithString("DEVELOPMENT")
        appendLog("【操作】设置开发环境")
    }
    @objc private func testSetProductionEnv() {
        AnalyticsSDK.shared.setEnvironmentWithString("PRODUCTION")
        appendLog("【操作】设置生产环境")
    }
    @objc private func testGetApiBaseUrl() {
        let url = AnalyticsSDK.shared.getApiBaseUrl()
        appendLog("【API BaseUrl】\(url)")
    }
    @objc private func testSetApiVersion() {
        AnalyticsSDK.shared.setApiVersion("v2")
        appendLog("【操作】设置API版本 v2")
    }
    // MARK: - 分享日志文件
    @objc private func shareLogFile() {
        // 获取日志文件路径
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let logFileURL = documentsDirectory.appendingPathComponent("TecdoSDK.log")
        guard FileManager.default.fileExists(atPath: logFileURL.path) else {
            appendLog("【分享日志】未找到日志文件")
            return
        }
        // 弹出日志预览sheet
        let previewVC = LogPreviewViewController(logFileURL: logFileURL)
        previewVC.modalPresentationStyle = .pageSheet
        if #available(iOS 15.0, *) {
            if let sheet = previewVC.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
            }
        } else {
            // Fallback on earlier versions
        }
        self.present(previewVC, animated: true, completion: nil)
    }

    // MARK: - 测试事件上传接口
    @objc private func testEventUploadAPI() {
        
    }

    @objc private func testTrackRegisterEvent() {
        let utmParams: [String: Any] = [
            "utm_source": "demo",
            "utm_medium": "test",
            "utm_campaign": "register"
        ]
        // 先设置 userId
        AnalyticsSDK.shared.setUserId("user_sdk_8888")
        AnalyticsSDK.shared.trackRegisterEvent(utmParams: utmParams)
        appendLog("【操作】先设置userId=user_sdk_8888，再上报用户注册事件 user_register，userId参数: user_123456, utm: \(utmParams)")
    }

    @objc private func testTrackRechargeEvent() {
        let utmParams: [String: Any] = [
            "utm_source": "demo",
            "utm_medium": "test",
            "utm_campaign": "recharge"
        ]
        AnalyticsSDK.shared.trackRechargeEvent(amount: 99.99, utmParams: utmParams)
        appendLog("【操作】上报用户充值事件 user_recharge，userId: user_123456, amount: 99.99, utm: \(utmParams)")
    }

    @objc private func testTrackFirstLaunchEvent() {
        AnalyticsSDK.shared.trackFirstLaunchEvent()
        appendLog("【操作】首次初始化事件已上报（仅第一次生效）")
    }

    @objc private func testAddUserProperty() {
        // 随机生成 key/value
        let key = "test_key_\(Int(Date().timeIntervalSince1970))"
        let value = "value_\(Int.random(in: 1000...9999))"
        AnalyticsSDK.shared.setUserProperty(key, value: value)
        appendLog("【操作】新增用户属性: \(key) = \(value)")
    }

    @objc private func testRemoveLastUserProperty() {
        let props = AnalyticsSDK.shared.getAllUserProperties()
        guard let lastKey = Array(props.keys).last else {
            appendLog("【操作】无用户属性可删除")
            return
        }
        AnalyticsSDK.shared.clearUserProperty(lastKey)
        appendLog("【操作】删除最后一个用户属性: \(lastKey)")
    }

    @objc private func testAddDeviceProperty() {
        let key = "dev_key_\(Int(Date().timeIntervalSince1970))"
        let value = "dev_value_\(Int.random(in: 1000...9999))"
        AnalyticsSDK.shared.setDeviceProperty(key, value: value)
        appendLog("【操作】新增设备属性: \(key) = \(value)")
    }

    @objc private func testRemoveLastDeviceProperty() {
        let props = AnalyticsSDK.shared.getAllDeviceProperties()
        guard let lastKey = Array(props.keys).last else {
            appendLog("【操作】无设备属性可删除")
            return
        }
        AnalyticsSDK.shared.clearDeviceProperty(lastKey)
        appendLog("【操作】删除最后一个设备属性: \(lastKey)")
    }

    @objc private func testShowAllDeviceProperties() {
        let devProps = AnalyticsSDK.shared.getAllDeviceProperties()
        appendLog("【设备属性DeviceProperty】\n" + devProps.map { "\($0): \($1)" }.joined(separator: ", "))
    }

    @objc private func testShowUserUaUtmInfo() {
        let userId = AnalyticsSDK.shared.getUserId() ?? "nil"
        let ua = AnalyticsSDK.shared.getUserAgentString()
        let utm = AnalyticsSDK.shared.getUtmParams()
        appendLog("【用户ID】\(userId)\n【UA】\(ua)\n【UTM】\(utm)")
    }

    @objc private func testGetUserAgent() {
        AnalyticsSDK.shared.getUserAgent { ua in
            self.appendLog("【设备UA】\n" + ua)
        }
    }
}
