//
//  ViewController.swift
//  CameraButtonExample
//
//  Created by Erik Drobne on 13/10/2022.
//

import UIKit
import SwiftUI
import CameraButton

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    // MARK: - Private methods

    private func setup() {
        let cameraButton = CameraButton()
        cameraButton.delegate = self

        view.addSubview(cameraButton)

        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cameraButton.widthAnchor.constraint(equalToConstant: 72),
            cameraButton.heightAnchor.constraint(equalToConstant: 72),
            cameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cameraButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        cameraButton.borderColor = .red
        cameraButton.fillColor = (.purple, .orange)
        cameraButton.progressColor = .green

        let button = UIButton()
        button.setTitle("CameraButtonUI", for: .normal)
        button.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
        view.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64)
        ])
    }

    private func cameraButtonUIController() -> UIViewController {
        let controller = UIHostingController(rootView: PhotoView())
        view.addSubview(controller.view)

        controller.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: view.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        return controller
    }

    @objc func buttonTap() {
        self.present(cameraButtonUIController(), animated: true)
    }
}

extension ViewController: CameraButtonDelegate {
    func didTap(_ button: CameraButton) {

    }

    func didFinishProgress() {

    }
}

