# CameraButton

A simple camera button that can be used for photo and video capturing. It's a subclass of the native `UIButton` with attributes for customization.

## Requirements

iOS 10 or higher 

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
