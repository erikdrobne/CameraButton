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

    var body: some View {
        CameraButtonUI(progressDuration: 5, isRecording: self.$isRecording)
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
            .onChange(of: isRecording, perform: { isRecording in
                print("record value", isRecording)
            })
    }
}

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView()
    }
}
