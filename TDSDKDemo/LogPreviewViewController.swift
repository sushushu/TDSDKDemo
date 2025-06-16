import UIKit
import UniformTypeIdentifiers

/// 日志预览Sheet弹窗
class LogPreviewViewController: UIViewController {
    private let logFileURL: URL
    private let textView = UITextView()
    private let shareButton = UIButton(type: .system)

    init(logFileURL: URL) {
        self.logFileURL = logFileURL
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTextView()
        setupShareButton()
        loadLogContent()
    }
    private func setupTextView() {
        textView.isEditable = false
        textView.font = UIFont.monospacedSystemFont(ofSize: 13, weight: .regular)
        textView.backgroundColor = UIColor(white: 0.97, alpha: 1)
        textView.textColor = .black
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
    }
    private func setupShareButton() {
        shareButton.setTitle("系统分享", for: .normal)
        shareButton.backgroundColor = .systemBlue
        shareButton.setTitleColor(.white, for: .normal)
        shareButton.layer.cornerRadius = 8
        shareButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        shareButton.addTarget(self, action: #selector(shareLog), for: .touchUpInside)
        view.addSubview(shareButton)
        NSLayoutConstraint.activate([
            shareButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            shareButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shareButton.heightAnchor.constraint(equalToConstant: 44),
            shareButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    private func loadLogContent() {
        do {
            let logText = try String(contentsOf: logFileURL, encoding: .utf8)
            textView.text = logText
        } catch {
            textView.text = "日志读取失败: \(error.localizedDescription)"
        }
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: shareButton.topAnchor, constant: -16)
        ])
    }
    @objc private func shareLog() {
        let activityVC = UIActivityViewController(activityItems: [logFileURL], applicationActivities: nil)
        if let popover = activityVC.popoverPresentationController {
            popover.sourceView = self.view
            popover.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.maxY - 50, width: 0, height: 0)
            popover.permittedArrowDirections = []
        }
        self.present(activityVC, animated: true, completion: nil)
    }
} 