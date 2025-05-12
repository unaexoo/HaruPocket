//
//  Color+Predefined.swift
//  HaruPocket
//
//  Created by 장지현 on 5/12/25.
//

import Foundation
import SwiftUI

extension Color {
    static var lightMainColor: Color { // 따뜻한 브라운 오렌지
        Color(red: 209/255, green: 145/255, blue: 88/255)
    }

    static var darkMainColor: Color { // 부드러운 피치 오렌지
        Color(red: 255/255, green: 185/255, blue: 128/255)
    }

    static var subColor: Color { // 연한 바닐라 베이지
        Color(red: 255/255, green: 244/255, blue: 230/255)
    }

    static var lightPointColor: Color { // 진한 지갑 테두리 컬러
        Color(red: 159/255, green: 107/255, blue: 63/255)
    }

    static var darkPointColor: Color { // 은은한 밝은 피치
        Color(red: 159/255, green: 107/255, blue: 63/255)
    }

    static var darkBrown: Color { // 다크 브라운
        Color(red: 75/255, green: 46/255, blue: 28/255)
    }

    static var creamWhite: Color { // 연한 크림 화이트
        Color(red: 245/255, green: 245/255, blue: 245/255)
    }
}
