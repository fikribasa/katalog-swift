//
//  ActivityIndicator.swift
//  dicoding-katalog
//
//  Created by User on 8/29/21.
//

import SwiftUI
import Foundation

struct ActivityIndicator: UIViewRepresentable {
    typealias UIViewType = UIActivityIndicatorView

    @Binding var isLoading: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: self.style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if self.isLoading {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }


}
