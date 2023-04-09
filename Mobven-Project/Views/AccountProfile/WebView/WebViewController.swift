//
//  WebViewController.swift
//  Mobven-Project
//
//  Created by Zehra on 8.04.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    static let identifier = "WebViewController"
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWebView()
        configureIndicator()
        configureToolbar()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "loading" {
            webView.isLoading ? indicator.startAnimating() : indicator.stopAnimating()
        }
    }
    
    private func configureWebView() {
        guard let url = URL(string: "https://www.linkedin.com/in/zehrakaramann") else { return }
        let request = URLRequest(url: url)
        
        DispatchQueue.main.async { [weak self] in
            self?.webView.load(request)
            self?.webView.allowsBackForwardNavigationGestures = true
        }
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.isLoading), context: nil)
    }
    
    func configureToolbar() {
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .done, target: webView, action: #selector(webView.goBack))
        let forwardButton = UIBarButtonItem(image: UIImage(systemName: "chevron.forward"), style: .done, target: webView, action: #selector(webView.goForward))
        let refreshButton = UIBarButtonItem(image: UIImage(systemName: "gobackward"), style: .done, target: webView, action: #selector(webView.reload))
        toolbar.tintColor = UIColor(named: "Blue - Light")
        toolbar.items = [backButton, refreshButton, forwardButton]
    }
    
    func configureIndicator() {
        indicator.style = .large
        indicator.color = UIColor(named: "Blue - Light")
        indicator.hidesWhenStopped = true
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else {
            decisionHandler(.cancel)
            return
        }
        if url.scheme == "mailto" || url.scheme == "tel" {
            UIApplication.shared.open(url)
            decisionHandler(.cancel)
        } else {
            if url.host == "www.linkedin.com" {
                decisionHandler(.allow)
            } else {
                decisionHandler(.cancel)
            }
        }
    }
}
