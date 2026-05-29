//
//  TimestampViewController.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import UIKit

final class TimestampViewController: BaseViewController {
    
    // MARK: - Dependencies
    
    private let parser =
    TimestampParser()
    
    private let formatter =
    TimestampFormatter()
    
    private var detectedClipboardTimestamp:
    String?
    // MARK: - State
    
    private var timer: Timer?
    
    private var isLiveMode = true
    
    // MARK: - Views
    
    private let contentView =
    TimestampContentView()
    
}

// MARK: - Lifecycle

extension TimestampViewController {
    
    override func loadView() {
        
        view =
        contentView
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupBindings()
        
        contentView
            .expressionInputView
            .setText("now")
        
        renderCurrentExpression()
        
        startLiveTimer()
    }
    
    override func viewDidDisappear(
        _ animated: Bool
    ) {
        
        super.viewDidDisappear(animated)
        
        stopLiveTimer()
    }
    
    override func viewDidAppear(
        _ animated: Bool
    ) {
        
        super.viewDidAppear(animated)
        
        detectClipboardTimestamp()
    }
}

// MARK: - Setup

private extension TimestampViewController {
    
    func setupBindings() {
        
        contentView
            .expressionInputView
            .onTextChanged = {
                [weak self] text in
                
                self?.handleInput(text)
            }
        
        contentView
            .representationsView
            .onCopyRepresentation = {
                [weak self] representation in
                
                self?.handleCopy(
                    representation
                )
            }
        
        contentView
            .quickChipsView
            .onChipSelected = {
                [weak self] chip in
                
                self?.handleChip(
                    chip
                )
            }
        
        contentView
            .clipboardBannerView
            .onConvert = {
                [weak self] in
                
                self?
                    .convertClipboardTimestamp()
            }
    }
    
    private func handleChip(
        _ chip: String
    ) {
        
        let current =
        contentView
            .expressionInputView
            .text
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
        
        var updated = current
        
        switch chip {
            
        case "Now":
            
            updated = "now"
            
        case "+1h":
            
            updated =
            current.isEmpty
            ? "now + 1h"
            : current + " + 1h"
            
        case "+1d":
            
            updated =
            current.isEmpty
            ? "now + 1d"
            : current + " + 1d"
            
        case "+1w":
            
            updated =
            current.isEmpty
            ? "now + 1w"
            : current + " + 1w"
            
        case "+1mo":
            
            updated =
            current.isEmpty
            ? "now + 1mo"
            : current + " + 1mo"
            
        case "+1y":
            
            updated =
            current.isEmpty
            ? "now + 1y"
            : current + " + 1y"
            
        default:
            return
        }
        
        print("CURRENT:", current)
        print("UPDATED:", updated)
        
        contentView
            .expressionInputView
            .setText(
                updated
            )
        
        HapticEngine.shared.light()
    }
}

// MARK: - Input

private extension TimestampViewController {
    
    func handleInput(
        _ text: String
    ) {
        let trimmed =
        text.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        let shouldLive =
        trimmed.isEmpty ||
        isDynamicExpression(
            trimmed
        )
        
        isLiveMode =
        shouldLive
        
        if shouldLive {
            
            startLiveTimer()
            
        } else {
            
            stopLiveTimer()
        }
        
        renderExpression(
            trimmed
        )
    }
    
    func isDynamicExpression(
        _ text: String
    ) -> Bool {
        
        let normalized =
        text.lowercased()
        
        return normalized.contains("now")
    }
    
    func resolvedExpression(
        _ text: String
    ) -> String {
        
        let nowTimestamp =
        String(
            Int(
                Date().timeIntervalSince1970
            )
        )
        
        let resolved =
        text.replacingOccurrences(
            of: "now",
            with: nowTimestamp,
            options: .caseInsensitive
        )
        
        return resolved
    }
}

// MARK: - Render

private extension TimestampViewController {
    
    func renderCurrentExpression() {
        
        let currentText =
        contentView
            .expressionInputView
            .text
        
        renderExpression(
            currentText
        )
    }
    
    func renderExpression(
        _ text: String
    ) {
        
        let resolved =
        resolvedExpression(
            text
        )
        
        guard
            let date =
                parser.parse(
                    input: resolved
                )
        else {
            return
        }
        
        render(date)
    }
    
    func render(
        _ date: Date
    ) {
        
        let result =
        formatter.makeResult(
            from: date
        )
        
        contentView
            .resultCardView
            .configure(
                with: result,
                isLive: isLiveMode
            )
        
        contentView
            .representationsView
            .configure(
                representations:
                    result.representations
            )
    }
}

// MARK: - Timer

private extension TimestampViewController {
    
    func startLiveTimer() {
        
        guard timer == nil else {
            return
        }
        
        timer =
        Timer.scheduledTimer(
            withTimeInterval: 1,
            repeats: true
        ) {
            [weak self] _ in
            
            guard
                let self,
                self.isLiveMode
            else {
                return
            }
            
            self.renderCurrentExpression()
        }
    }
    
    func stopLiveTimer() {
        
        timer?.invalidate()
        
        timer = nil
    }
}

// MARK: - Copy

private extension TimestampViewController {
    
    func handleCopy(
        _ representation: TimestampRepresentation
    ) {
        
        UIPasteboard.general.string =
        representation.copyValue
        
        HapticEngine.shared.light()
        
        ToastPresenter.shared.show(
            message: "Copied \(representation.title)",
            in: view
        )
    }
}

extension TimestampViewController {

    private func detectClipboardTimestamp() {

        guard
            let value =
                UIPasteboard.general.string?
                .trimmingCharacters(
                    in: .whitespacesAndNewlines
                )
        else {
            return
        }

        guard
            value.count == 10 ||
            value.count == 13
        else {
            return
        }

        guard
            value.allSatisfy(\.isNumber)
        else {
            return
        }

        detectedClipboardTimestamp =
            value

        contentView
            .clipboardBannerView
            .configure(
                value: value
            )

        contentView
            .clipboardBannerView
            .isHidden = false

        print("SHOW BANNER:", value)
    }
    
    private func convertClipboardTimestamp() {
        
        guard
            let value =
                detectedClipboardTimestamp
        else {
            return
        }
        
        contentView
            .expressionInputView
            .setText(
                value
            )
        
        contentView
            .clipboardBannerView
            .isHidden = true
        
        HapticEngine.shared.light()
    }
}
