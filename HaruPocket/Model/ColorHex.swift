//
//  ColorHex.swift
//  HaruPocket
//
//  Created by 윤혜주 on 5/12/25.
//

import Foundation
import SwiftUI
import UIKit

/// `Color`에 대한 HEX 변환 유틸리티 확장입니다.
/// - HEX 문자열을 기반으로 색상을 초기화하거나, `Color` 값을 HEX 문자열로 변환할 수 있습니다.
extension Color {
    /// `Color`를 HEX 문자열로 변환합니다.
    /// - Returns: `#RRGGBB` 형식의 문자열 또는 변환 실패 시 nil
    func toHex() -> String? {
        let uiColor = UIColor(self)
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        guard uiColor.getRed(&r, green: &g, blue: &b, alpha: &a) else {
            return nil
        }
        return String(
            format: "#%02X%02X%02X",
            Int(r * 255),
            Int(g * 255),
            Int(b * 255)
        )
    }

    /// HEX 문자열을 기반으로 `Color`를 초기화합니다.
    /// - Parameter hexString: `#RRGGBB` 또는 `RRGGBB` 형식의 문자열
    init(hexString: String) {
        var hex = hexString
        if hex.hasPrefix("#") { hex.removeFirst() }
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        let r = Double((rgb >> 16) & 0xFF) / 255
        let g = Double((rgb >> 8) & 0xFF) / 255
        let b = Double(rgb & 0xFF) / 255
        self = Color(red: r, green: g, blue: b)
    }
}
