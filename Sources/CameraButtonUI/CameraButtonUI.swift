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

    private var center: CGPoint {
        return CGPoint(x: size * 0.5, y: size * 0.5)
    }

    @State private var scalingFactor: CGFloat = 1
    @State private var percentage: CGFloat = .zero

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

            Circle()
                .trim(from: 0, to: percentage)
                .stroke(Color.green, style: StrokeStyle(lineWidth: size * 0.08, lineCap: .round))
                .padding(size * 0.08/2)
                .frame(width: size, height: size)
                .animation(.easeOut(duration: 2.0), value: percentage)
                .onAppear {
                    self.percentage = 1.0
                }
        }
        .frame(width: size, height: size)
        //.border(.red)
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
