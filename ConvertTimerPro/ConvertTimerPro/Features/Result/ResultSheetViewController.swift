//
//  ResultSheetViewController.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class ResultSheetViewController:
    BaseViewController {
    
    private let resultTitle: String
    
    private let resultValue: String
    
    init(
        title: String,
        value: String
    ) {
        
        self.resultTitle =
        title
        
        self.resultValue =
        value
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
        modalPresentationStyle =
            .pageSheet
    }
    
    required init?(
        coder: NSCoder
    ) {
        
        fatalError()
    }
    
    private let cardView =
    AppCardView()
    
    private let titleLabel =
    UILabel().then {
        
        $0.font =
        AppFont.bodyMedium()
        
        $0.textColor =
        AppColor.Text.secondary
        
        $0.textAlignment =
            .center
    }
    
    private let valueLabel =
    UILabel().then {
        
        $0.font =
            .systemFont(
                ofSize: 32,
                weight: .bold
            )
        
        $0.textColor =
        AppColor.Accent.primary
        
        $0.textAlignment =
            .center
        
        $0.numberOfLines = 0
    }
    
    private let copyButton =
    UIButton(type: .system).then {
        
        $0.setTitle(
            "Copy",
            for: .normal
        )
    }
    
    private let closeButton =
    UIButton(type: .system).then {
        
        $0.setTitle(
            "Close",
            for: .normal
        )
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupSheet()
        
        setupContent()
    }
}

private extension ResultSheetViewController {
    
    func setupSheet() {
        
        if let sheet =
            sheetPresentationController {
            
            sheet.detents = [
                
                .medium()
            ]
            
            sheet.prefersGrabberVisible =
            true
        }
    }
}

private extension ResultSheetViewController {
    
    func setupContent() {
        
        view.backgroundColor =
        AppColor.Background.primary
        
        view.addSubview(cardView)
        
        cardView.addSubview(
            titleLabel
        )
        
        cardView.addSubview(
            valueLabel
        )
        
        cardView.addSubview(
            copyButton
        )
        
        cardView.addSubview(
            closeButton
        )
        
        titleLabel.text =
        resultTitle
        
        valueLabel.text =
        resultValue
        
        cardView.snp.makeConstraints {
            
            $0.leading.trailing
                .equalToSuperview()
                .inset(20)
            
            $0.centerY.equalToSuperview()
            
            $0.height.equalTo(260)
        }
        
        titleLabel.snp.makeConstraints {
            
            $0.top.equalToSuperview()
                .offset(24)
            
            $0.leading.trailing
                .equalToSuperview()
                .inset(16)
        }
        
        valueLabel.snp.makeConstraints {
            
            $0.top.equalTo(
                titleLabel.snp.bottom
            ).offset(20)
            
            $0.leading.trailing
                .equalToSuperview()
                .inset(24)
        }
        
        copyButton.snp.makeConstraints {
            
            $0.leading.equalToSuperview()
                .offset(24)
            
            $0.bottom.equalToSuperview()
                .offset(-24)
            
            $0.height.equalTo(44)
        }
        
        closeButton.snp.makeConstraints {
            
            $0.trailing.equalToSuperview()
                .offset(-24)
            
            $0.bottom.equalToSuperview()
                .offset(-24)
            
            $0.height.equalTo(44)
        }
        
        copyButton.addTarget(
            self,
            action: #selector(
                didTapCopy
            ),
            for: .touchUpInside
        )
        
        closeButton.addTarget(
            self,
            action: #selector(
                didTapClose
            ),
            for: .touchUpInside
        )
    }
}

private extension ResultSheetViewController {
    @objc
    func didTapCopy() {
        
        UIPasteboard.general.string =
        resultValue
        
        let generator =
        UINotificationFeedbackGenerator()
        
        generator.notificationOccurred(
            .success
        )
        
        dismiss(
            animated: true
        ) {
            ToastPresenter.shared.show(
                message: "Copied to clipboard"
            )
        }
    }
    
    @objc
    func didTapClose() {
        
        dismiss(
            animated: true
        )
    }
}
