//
//  BaseViewController.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 27/5/26.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        initialize()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        setupAfterLayout()
    }

    // MARK: - Status Bar

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    // MARK: - Navigation Actions

    func setupNavigationActions(
        copyAction: Selector? = nil,
        shareAction: Selector? = nil
    ) {

        var items:
            [UIBarButtonItem] = []

        if let shareAction {

            let shareItem =
                UIBarButtonItem(
                    image: UIImage(
                        systemName: "square.and.arrow.up"
                    ),
                    style: .plain,
                    target: self,
                    action: shareAction
                )

            items.append(
                shareItem
            )
        }

        if let copyAction {

            let copyItem =
                UIBarButtonItem(
                    image: UIImage(
                        systemName: "doc.on.doc"
                    ),
                    style: .plain,
                    target: self,
                    action: copyAction
                )

            items.append(
                copyItem
            )
        }

        navigationItem.rightBarButtonItems =
            items
    }
    
    // MARK: - Deinit

    deinit {

        #if DEBUG
        print("🔥 Deinit:", String(describing: Self.self))
        #endif
    }
}

// MARK: - Private

private extension BaseViewController {

    func initialize() {

        setupView()
        setupConstraints()
        setupStyle()
        bind()
        setupData()
    }
}

// MARK: - Override Points

@objc
extension BaseViewController {

    /// Add subviews here
    func setupView() { }

    /// Setup SnapKit constraints here
    func setupConstraints() { }

    /// Configure colors/fonts/shadows here
    func setupStyle() { }

    /// Bind actions / Combine / notifications here
    func bind() { }

    /// Setup initial static data here
    func setupData() { }

    /// Called after auto-layout finished
    func setupAfterLayout() { }
}
