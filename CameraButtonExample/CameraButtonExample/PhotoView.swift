//
//  PhotoView.swift
//  CameraButtonExample
//
//  Created by Erik Drobne on 02/12/2022.
//

import SwiftUI
import CameraButton

struct PhotoView: View {

    @State var isRecording: Bool = false
    @State var didFinishProgress: Bool = false

    var body: some View {
        CameraButtonUI(progressDuration: 5, isRecording: self.$isRecording, didFinishProgress: self.$didFinishProgress)
            .simultaneousGesture(
                TapGesture()
                    .onEnded { _ in
                        print("tapped")
                    }
            )
            .gesture(
                LongPressGesture(minimumDuration: 1)
                    .onChanged { val in
                        isRecording = true
                    }
            )
            .onChange(of: isRecording, perform: { [isRecording] newValue in
                print("isRecording", isRecording, newValue)
            })
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView()
    }
}
