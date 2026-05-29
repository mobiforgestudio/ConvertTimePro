//
//  BaseView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 27/5/26.
//

import UIKit

class BaseView: UIView {

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)

        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private

private extension BaseView {

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
extension BaseView {

    /// Add subviews here
    func setupView() { }

    /// Setup SnapKit constraints here
    func setupConstraints() { }

    /// Configure colors/fonts/shadows here
    func setupStyle() { }

    /// Bind actions/events/observables here
    func bind() { }
    
    func setupData() { }
}
