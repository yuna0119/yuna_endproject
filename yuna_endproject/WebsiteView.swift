//
//  WebsiteView.swift
//  yuna_endproject
//
//  Created by user05 on 2023/12/10.
//

import SwiftUI
import WebKit

struct WebsiteView: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
    
    typealias UIViewType = WKWebView
}
