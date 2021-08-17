//
//  ViewController.swift
//  EasyBrowser
//
//  Created by Logesh Palani on 17/08/21.
//

import UIKit
import WebKit
class ViewController: UIViewController, WKNavigationDelegate {
    @objc var webview: WKWebView!
    var progressView: UIProgressView!
    var websites = ["apple.com","google.com","microsoft.com"]
    override func loadView() {
        webview = WKWebView()
        webview.navigationDelegate = self
        view = webview
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = URL(string: "https://www.bing.com")!
        webview.load(URLRequest(url:url))
        webview.allowsBackForwardNavigationGestures = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progress = UIBarButtonItem(customView: progressView)
        let speacing = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let reload = UIBarButtonItem(barButtonSystemItem: .refresh, target: webview, action: #selector(webview.reload))
        let forward = UIBarButtonItem(title: ">", style: .plain, target: toolbarItems, action: #selector(webview.goForward))
        
        let backward = UIBarButtonItem(title: "<", style: .plain, target: toolbarItems, action: #selector(webview.goBack))
        
        toolbarItems = [progress, speacing,forward,backward, reload]
        navigationController?.isToolbarHidden = false
        
        webview.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webview.estimatedProgress)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        webview.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
    @objc func openTapped(){
        let ac = UIAlertController(title: "Open page,..", message: nil, preferredStyle: .actionSheet)
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
       
        present(ac, animated: true)
    }
    func openPage(action: UIAlertAction) {
        guard action.title != nil else {
            return
        }
        let url = URL(string: "https://" + action.title!)!
        webview.load(URLRequest(url: url))
    }
    
    // after loading set the title of page is webpage title
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webview.title
    }
    
    // check the processing website is our website else don't load the website
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        
        if let host = url?.host {
            for website in websites {
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                }
            }
        }
        let alert = UIAlertController(title: "Blocked", message: "Website not allowed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
        decisionHandler(.cancel)
    }
}

