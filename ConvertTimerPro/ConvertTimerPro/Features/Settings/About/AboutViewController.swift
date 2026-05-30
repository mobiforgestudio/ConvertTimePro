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

    func setupVersion() {

        let version =
            Bundle.main.object(
                forInfoDictionaryKey:
                "CFBundleShortVersionString"
            ) as? String ?? "1.0"

        let build =
            Bundle.main.object(
                forInfoDictionaryKey:
                "CFBundleVersion"
            ) as? String ?? "1"

        contentView.versionLabel.text =
            "Version \(version) (\(build))"
    }
}
