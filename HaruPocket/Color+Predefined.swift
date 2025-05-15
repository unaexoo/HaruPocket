//
//  Color+Predefined.swift
//  HaruPocket
//
//  Created by 장지현 on 5/12/25.
//

import Foundation
import SwiftUI

/// 앱 전반에서 사용하는 미리 정의된 색상(Color) 확장입니다.
/// - 라이트/다크 모드 또는 특정 UI 요소에 적합한 색상을 제공합니다.
extension Color {

    /// 라이트 모드에서 사용되는 메인 색상입니다. (따뜻한 브라운 오렌지)
    static var lightMainColor: Color {
        Color(red: 209 / 255, green: 145 / 255, blue: 88 / 255)
    }

    /// 다크 모드에서 사용되는 메인 색상입니다. (부드러운 피치 오렌지)
    static var darkMainColor: Color {
        Color(red: 255 / 255, green: 185 / 255, blue: 128 / 255)
    }

    /// 연한 배경에 사용되는 서브 색상입니다. (연한 바닐라 베이지)
    static var subColor: Color {
        Color(red: 255 / 255, green: 244 / 255, blue: 230 / 255)
    }

    /// 라이트 모드에서 포인트 또는 텍스트 강조에 사용되는 색상입니다. (진한 지갑 테두리 컬러)
    static var lightPointColor: Color {
        Color(red: 159 / 255, green: 107 / 255, blue: 63 / 255)
    }

    /// 다크 모드에서 포인트 또는 강조 텍스트에 사용되는 색상입니다. (은은한 밝은 피치)
    static var darkPointColor: Color {
        Color(red: 255 / 255, green: 185 / 255, blue: 128 / 255)
    }

    /// 어두운 배경에 적합한 브라운 계열 색상입니다. (다크 브라운)
    static var darkBrown: Color {
        Color(red: 75 / 255, green: 46 / 255, blue: 28 / 255)
    }

    /// 앱 전반에 배경으로 사용되는 밝은 색상입니다. (연한 크림 화이트)
    static var creamWhite: Color {
        Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255)
    }
}
