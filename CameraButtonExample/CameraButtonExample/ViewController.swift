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

//        setup()

        let controller = UIHostingController(rootView: PhotoView())
        view.addSubview(controller.view)

        controller.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            controller.view.topAnchor.constraint(equalTo: view.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    // MARK: - Private methods

    private func setup() {
        let button = CameraButton()
        button.delegate = self

        view.addSubview(button)

        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 72),
            button.heightAnchor.constraint(equalToConstant: 72),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])

        button.borderColor = .red
        button.fillColor = (.purple, .orange)
        button.progressColor = .green
    }
}

extension ViewController: CameraButtonDelegate {
    func didTap(_ button: CameraButton) {

    }

    func didFinishProgress() {

    }
}

