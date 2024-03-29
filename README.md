# CameraButton

![RPReplay_Final1642669292](https://user-images.githubusercontent.com/15943419/150314796-160a77d0-2755-4222-bf40-b1d965f0a97e.GIF)
![RPReplay_Final1642670033](https://user-images.githubusercontent.com/15943419/150314815-8524644c-9f20-4b74-9afc-acb6871dc877.GIF)

A simple camera button that can be used for photo and video capturing.

## Requirements

**iOS 14.0** or higher

## Instalation

### Swift Package Manager

```Swift
dependencies: [
    .package(url: "https://github.com/erikdrobne/CameraButton")
]
```

## Usage

### Import

```Swift
import CameraButton
```

### UIKit

### Initialize

```Swift
let button = CameraButton()
button.delegate = self
view.addSubview(button)
button.translatesAutoresizingMaskIntoConstraints = false

NSLayoutConstraint.activate([
    button.widthAnchor.constraint(equalToConstant: 72),
    button.heightAnchor.constraint(equalToConstant: 72),
    button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
    button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64)
])
```

### Customize

```Swift
// Set custom colors
button.borderColor = .red
button.fillColor = (.purple, .orange)
button.progressColor = .green

// Set progress animation duration
button.progressDuration = 5

// Start progress animation
button.start()

// Stop progress animation
button.stop()
```

### Delegate

The `CameraButtonDelegate` requires you to implement the following methods:

```Swift
func didTap(_ button: CameraButton)
func didFinishProgress()
```

### SwiftUI

```Swift
struct PhotoView: View {

    @State var isRecording: Bool = false
    @State var didFinishProgress: Bool = false

    var body: some View {
        CameraButtonUI(
            size: 72,
            borderColor: .red,
            fillColor: (.purple, .orange),
            progressColor: .green,
            progressDuration: 5,
            isRecording: self.$isRecording
        )
        // Handle tap gesture
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    print("tap")
                }
        )
        // Start recording on Long-press gesture
        .gesture(
            LongPressGesture(minimumDuration: 1)
                .onChanged { val in
                    isRecording = true
                }
        )
        // Observe state changes
        .onChange(of: isRecording, perform: { [isRecording] newValue in
            print("isRecording", isRecording, newValue)
        })
    }
}
```
