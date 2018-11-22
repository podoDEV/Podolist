//
//  CommonWebViewController.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa

final class CommonWebViewController: UIViewController {
    private var webView: WKWebView!
    private var loadingView: UIActivityIndicatorView!
    private var url: URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        reload()
    }

    func setupSubviews() {
        webView = WKWebView()
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.backgroundColor = .white
        view.addSubview(webView)

        loadingView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        loadingView.color = .gray
        view.addSubview(loadingView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.bounds.size = view.frame.size
    }
}

private extension CommonWebViewController {

    func reload() {
        let request = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData)
//        request.addValue(XAuthClientID(), forHTTPHeaderField: "X-AUTH-CLIENT_ID")
//        request.addValue(self.accessToken, forHTTPHeaderField: "X-AUTH-TOKEN")
//        request.addValue("ios", forHTTPHeaderField: "clientOs")
//        request.addValue(AppUtils.version, forHTTPHeaderField: "clientVersion")
        webView.load(request)
    }
}

extension CommonWebViewController: WKNavigationDelegate, WKUIDelegate {

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        loadingView.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        if loadingView.isAnimating {
            loadingView.stopAnimating()
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        if loadingView.isAnimating {
            loadingView.stopAnimating()
        }
    }
}
