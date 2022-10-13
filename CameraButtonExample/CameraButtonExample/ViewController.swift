//
//  ViewController.swift
//  CameraButtonExample
//
//  Created by Erik Drobne on 13/10/2022.
//

import UIKit
import CameraButton

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
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
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64)
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

