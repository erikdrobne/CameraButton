//
//  ReversingScale.swift
//  
//
//  Created by Erik Drobne on 23/11/2022.
//

import Foundation
import SwiftUI

struct ReversingScale: AnimatableModifier {
    var value: CGFloat

    private let target: CGFloat
    private let onEnded: () -> ()

    init(to value: CGFloat, onEnded: @escaping () -> () = {}) {
        self.target = value
        self.value = value
        self.onEnded = onEnded
    }

    var animatableData: CGFloat {
        get { value }
        set { value = newValue
            let callback = onEnded
            if newValue == target {
                DispatchQueue.main.async(execute: callback)
            }
        }
    }

    func body(content: Content) -> some View {
        content.scaleEffect(value)
    }
}
