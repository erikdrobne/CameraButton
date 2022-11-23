//
//  CameraButtonUI.swift
//  
//
//  Created by Erik Drobne on 14/10/2022.
//

import SwiftUI

public struct CameraButtonUI: View {

    // MARK: - Private properties

    private let size: CGFloat = 72
    private var borderColor = Color.purple
    private var fillColor: (default: Color, record: Color) = (.blue, .red)

    @State private var scalingFactor: CGFloat = 1

    public init(borderColor: SwiftUI.Color = Color.purple, fillColor: (default: Color, record: Color) = (.blue, .red)) {
        self.borderColor = borderColor
        self.fillColor = fillColor
    }

    public var body: some View {
        ZStack {
            Circle()
                .strokeBorder(borderColor, lineWidth: size * 0.05)
                .background(Circle().fill(.clear))
                .frame(width: size, height: size)

            Circle()
                .fill(fillColor.default)
                .padding(size * 0.08)
                .frame(width: size, height: size)
                .modifier(ReversingScale(to: scalingFactor) {
                    DispatchQueue.main.async {
                        self.scalingFactor = 1
                    }
                })
                .animation(.easeInOut(duration: 0.15), value: scalingFactor)
        }
        .onTapGesture {
            self.scalingFactor = 0.9
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CameraButtonUI()
    }
}
