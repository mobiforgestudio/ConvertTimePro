//
//  ExpressionInputView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 28/5/26.
//

import UIKit
import SnapKit
import Then

final class ExpressionInputView: BaseView {

    // MARK: - Public

    var onTextChanged: ((String) -> Void)?

    var onDidEndEditing: (() -> Void)?
    
    var text: String {
        textView.text ?? ""
    }

    // MARK: - Dependencies

    private let syntaxHighlighter: SyntaxHighlighting

    private let validator =
        ExpressionValidator()
    
    private var validationRanges:
        [NSRange] = []
    
    // MARK: - Views

    private let cardView = GlassCardView(
        contentInsets: UIEdgeInsets(
            top: AppSpacing.md,
            left: AppSpacing.lg,
            bottom: AppSpacing.md,
            right: AppSpacing.lg
        )
    )

    private let textView = UITextView().then {
        $0.backgroundColor = .clear
        $0.textColor = AppColor.Text.primary
        $0.font = AppFont.expressionInput()
        $0.tintColor = AppColor.Accent.primary

        $0.textContainerInset = .zero
        $0.textContainer.lineFragmentPadding = 0

        $0.isScrollEnabled = false

        $0.autocorrectionType = .no
        $0.autocapitalizationType = .none
        $0.smartQuotesType = .no
        $0.smartDashesType = .no

        $0.keyboardAppearance = .dark
        $0.returnKeyType = .done
    }

    private let placeholderLabel = UILabel().then {
        $0.text = "Enter expression"
        $0.font = AppFont.expressionInput()
        $0.textColor = AppColor.Text.tertiary
        $0.numberOfLines = 1
    }

    private let clearButton = UIButton(
        type: .system
    ).then {

        $0.setImage(
            UIImage(
                systemName: "xmark.circle.fill"
            ),
            for: .normal
        )

        $0.tintColor =
            AppColor.Text.tertiary

        $0.alpha = 0
    }

    // MARK: - Setup

    init(
        syntaxHighlighter:
            SyntaxHighlighting =
                ExpressionSyntaxHighlighter()
    ) {

        self.syntaxHighlighter =
            syntaxHighlighter

        super.init(
            frame: .zero
        )
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupView() {

        addSubview(cardView)

        cardView.contentView.addSubview(
            textView
        )

        cardView.contentView.addSubview(
            placeholderLabel
        )

        cardView.contentView.addSubview(
            clearButton
        )

        textView.delegate = self
    }

    override func setupConstraints() {

        cardView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        clearButton.snp.makeConstraints {
            $0.right.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }

        textView.snp.makeConstraints {
            $0.left.top.bottom.equalToSuperview()

            $0.right.equalTo(
                clearButton.snp.left
            ).offset(-AppSpacing.sm)
        }

        placeholderLabel.snp.makeConstraints {

            $0.left.equalTo(textView)

            $0.top.equalTo(textView)
                .offset(2)

            $0.right.lessThanOrEqualTo(
                clearButton.snp.left
            ).offset(-AppSpacing.sm)
        }
    }

    override func setupStyle() {

        backgroundColor = .clear
    }

    override func bind() {

        clearButton.addTarget(
            self,
            action: #selector(
                didTapClearButton
            ),
            for: .touchUpInside
        )
    }
}

// MARK: - Public

extension ExpressionInputView {

    var selectedRange: NSRange {
        textView.selectedRange
    }

    func setCursor(location: Int) {
        let safeLocation = min(
            max(0, location),
            (textView.text as NSString).length
        )

        textView.selectedRange = NSRange(
            location: safeLocation,
            length: 0
        )
    }
    
    func showValidationError(
        range: NSRange
    ) {

        validationRanges = [range]

        applyHighlightedText(
            text
        )
    }

    func clearValidation() {

        validationRanges = []

        applyHighlightedText(
            text
        )
    }
    
    func setText(
        _ text: String,
        moveCursorToEnd: Bool = true
    ) {

        applyHighlightedText(
            text
        )

        if moveCursorToEnd {

            let endPosition = NSRange(
                location: text.count,
                length: 0
            )

            textView.selectedRange =
                endPosition
        }

        updatePlaceholder()

        updateClearButton()

        onTextChanged?(text)
    }

    func focus() {

        textView.becomeFirstResponder()
    }

    func resignFocus() {

        textView.resignFirstResponder()
    }
}

// MARK: - Private

private extension ExpressionInputView {

    @objc
    func didTapClearButton() {

        setText("")

        textView.becomeFirstResponder()
    }

    func updatePlaceholder() {

        placeholderLabel.isHidden =
            !text.isEmpty
    }

    func updateClearButton() {

        UIView.animate(
            withDuration: AppAnimation.fast,
            delay: 0,
            options: [
                .curveEaseOut,
                .allowUserInteraction
            ]
        ) {

            self.clearButton.alpha =
                self.text.isEmpty ? 0 : 1
        }
    }
    
    func applyHighlightedText(
        _ text: String
    ) {

        let validationErrors =
            validationRanges.map {

                ExpressionValidationError(
                    range: $0,
                    message: "Invalid"
                )
            }

        let attributedText =
            syntaxHighlighter.highlight(
                text: text,
                validationErrors:
                    validationErrors
            )

        textView.attributedText =
            attributedText
    }
}

// MARK: - UITextViewDelegate

extension ExpressionInputView:
    UITextViewDelegate {

    func textViewDidChange(
        _ textView: UITextView
    ) {

        let currentText =
            textView.text ?? ""

        let selectedRange =
            textView.selectedRange

        applyHighlightedText(
            currentText
        )

        textView.selectedRange =
            selectedRange

        updatePlaceholder()

        updateClearButton()

        onTextChanged?(currentText)
    }

    func textView(
        _ textView: UITextView,
        shouldChangeTextIn range: NSRange,
        replacementText text: String
    ) -> Bool {

        if text == "\n" {

            textView.resignFirstResponder()

            return false
        }

        return true
    }

    func textViewDidBeginEditing(
        _ textView: UITextView
    ) {

        UIView.animate(
            withDuration: AppAnimation.fast
        ) {

            self.cardView.layer.borderColor =
                AppColor.Accent.primary.cgColor
        }
    }

    func textViewDidEndEditing(
        _ textView: UITextView
    ) {
        onDidEndEditing?()
        UIView.animate(
            withDuration: AppAnimation.fast
        ) {

            self.cardView.layer.borderColor =
                AppColor.Border.subtle.cgColor
        }
    }
}
