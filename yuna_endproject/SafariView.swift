//
//  SafariView.swift
//  yuna_endproject
//
//  Created by user05 on 2023/12/13.
//
import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // Leave this empty
    }
}
