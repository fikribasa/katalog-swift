//
//  ResourceExtension.swift
//  dicoding-katalog
//
//  Created by User on 8/29/21.
//

import SwiftUI

extension Color {
    static let mainBg = Color(red: 74 / 255, green: 35 / 255, blue: 90 / 255)
    static let primaryText = Color("gray")
    static let gray80 = Color("gray80")
    static let gray20 = Color("gray20")
}

extension CGFloat {
    static let spacingSmall: CGFloat = 4
    static let spacingNormal: CGFloat = 8
    static let spacingLarge: CGFloat = 16
}

extension Image {
    static let previewImage: Image = Image("previewImage")
    static let calendar: Image = Image(systemName: "calendar")
    static let timer: Image = Image(systemName: "timer")
    static let search: Image = Image(systemName: "magnifyingglass")
    static let starFill: Image = Image(systemName: "star.fill")
    static let background: Image = Image("background")
}

extension String {
    func convertToDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self)!
        return date
    }
}

extension Date {
    func convertToString(format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
