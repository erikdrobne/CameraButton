//
//  CameraButtonUI.swift
//  
//
//  Created by Erik Drobne on 14/10/2022.
//

import SwiftUI

public struct CameraButtonUI: View {

    private typealias ProgressDuration = (record: TimeInterval, cleanup: TimeInterval)

    // MARK: - Public properties

    public let borderColor: Color
    public let fillColor: (default: Color, record: Color)
    public let progressColor: Color
    
    @Binding public var isRecording: Bool

    // MARK: - Private properties

    private let duration: ProgressDuration
    private let size: CGFloat = 72
    private var center: CGPoint {
        return CGPoint(x: size * 0.5, y: size * 0.5)
    }

    @State private var scalingFactor: CGFloat = 1
    @State private var percentage: CGFloat = .zero

    public init(borderColor: Color = .white, fillColor: (default: Color, record: Color) = (.white, .white), progressColor: Color = .red, progressDuration: TimeInterval, isRecording: Binding<Bool>) {
        self.borderColor = borderColor
        self.fillColor = fillColor
        self.progressColor = progressColor
        self.duration = (progressDuration, 0.2)
        self._isRecording = isRecording
    }

    public var body: some View {
        ZStack {
            if isRecording {
                Circle()
                    .fill(progressColor)
                    .frame(width: size, height: size)
            } else {
                Circle()
                    .strokeBorder(borderColor, lineWidth: size * 0.05)
                    .frame(width: size, height: size)
            }
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
                .stroke(
                    fillColor.record,
                    style: StrokeStyle(lineWidth: size * 0.08, lineCap: .round)
                )
                .padding(size * 0.01)
                .frame(width: size, height: size)
                .animation(.linear(duration: isRecording ? duration.record : duration.cleanup), value: percentage)
                .onAppear {

                }
        }
        .frame(width: size, height: size)
        .onTapGesture {
            didTap()
        }
        .onChange(of: isRecording, perform: { isRecording in
            if isRecording {
                start()
            } else {
                stop()
            }
        })
    }

    // MARK: - Private methods

    private func didTap() {
        self.scalingFactor = 0.9

        guard isRecording else {
            return
        }

        isRecording = false
    }

    private func clear() {
        self.percentage = 0
    }

    private func start() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        self.percentage = 1.0
    }

    private func stop() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        clear()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        CameraButtonUI(progressDuration: 5, isRecording: .constant(false))
    }
}
