//
//  AboutViewController.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit

final class AboutViewController:
    BaseViewController {

    private let contentView =
        AboutContentView()

    override func loadView() {

        view = contentView
    }

    override func viewDidLoad() {

        super.viewDidLoad()

        title = "About"

        setupVersion()
    }
}

private extension AboutViewController {

    private func setupVersion() {

        let version =
            Bundle.main.infoDictionary?[
                "CFBundleShortVersionString"
            ] as? String ?? ""

        let build =
            Bundle.main.infoDictionary?[
                "CFBundleVersion"
            ] as? String ?? ""

        contentView.versionLabel.text =
            "Version \(version) (\(build))"
    }
}
