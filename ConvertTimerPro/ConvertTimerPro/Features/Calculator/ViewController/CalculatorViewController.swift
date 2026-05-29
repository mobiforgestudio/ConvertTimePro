//
//  CalculatorViewController.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 27/5/26.
//

import UIKit
import SnapKit
import Then
import SwiftData

final class CalculatorViewController:
    BaseViewController {
    
    // MARK: - Views
    
    private let contentView =
    CalculatorContentView()
    
    // MARK: - Dependencies
    
    private let parser =
    ExpressionParser()
    
    private let grammarValidator =
    ExpressionGrammarValidator()
    
    private let expressionFormatter =
    ExpressionFormatter()
    
    private lazy var historyStore = HistoryStore(
        context:
            PersistenceController
            .shared
            .container
            .mainContext
    )
    
    private let autocompleteEngine =
    AutocompleteEngine()
    
    private var isRestoringHistory =
    false
    
    // MARK: - Data
    
    private var historySaveWorkItem:
    DispatchWorkItem?
    
    private let suggestions: [
        ExpressionSuggestion
    ] = [
        
        ExpressionSuggestion(
            title: "Now",
            expression: "now",
            behavior: .replace
        ),
        
        ExpressionSuggestion(
            title: "+1h",
            expression: "+ 1h",
            behavior: .append
        ),
        
        ExpressionSuggestion(
            title: "+1d",
            expression: "+ 1d",
            behavior: .append
        ),
        
        ExpressionSuggestion(
            title: "Morning",
            expression: "8am",
            behavior: .replace
        ),
        
        ExpressionSuggestion(
            title: "Work End",
            expression: "17:30",
            behavior: .replace
        ),
        
        ExpressionSuggestion(
            title: "Lunch",
            expression: "12:00 + 1h",
            behavior: .replace
        )
    ]
    
    // MARK: - Lifecycle
    
    override func loadView() {
        
        view = contentView
    }
    
    // MARK: - Setup
    
    override func setupData() {
        
        title = "Calculator"
        
        setupSuggestionChips()
        
        setupInitialState()
        
        reloadAllSections()
    }
    
    override func bind() {
        
        contentView
            .expressionInputView
            .onTextChanged = {
                [weak self] text in
                
                self?.handleExpression(
                    text
                )
            }
        
        contentView
            .expressionInputView
            .onDidEndEditing = {
                [weak self] in
                
                self?.normalizeExpression()
            }
        
        bindRecordSections()
    }
    
    func bindRecordSections() {

        [
            contentView.historySectionView,
            contentView.favoritesSectionView
        ]
        .forEach {

            $0.onSelectHistory = {
                [weak self] record in

                self?.handleSelectRecord(
                    record
                )
            }

            $0.onDeleteHistory = {
                [weak self] record in

                self?.handleDeleteRecord(
                    record
                )
            }

            $0.onTogglePinHistory = {
                [weak self] record in

                self?.handleTogglePin(
                    record
                )
            }
        }
    }
    
}

// MARK: - Private

private extension CalculatorViewController {
    
    // MARK: Initial State
    
    func setupInitialState() {
        
        let model =
        ResultViewModel(
            
            timeText: "--:--",
            
            dateText:
                "Live Preview",
            
            expressionText:
                "Start typing..."
        )
        
        contentView
            .resultCardView
            .configure(
                with: model,
                animated: false
            )
        
        contentView.breakdownContainerView.configure(
            items: []
        )
    }
    
    // MARK: Suggestion Chips
    
    func setupSuggestionChips() {
        
        suggestions.forEach {
            suggestion in
            
            let chip = ChipView(
                title: suggestion.title
            )
            
            chip.addAction(
                UIAction {
                    [weak self] _ in
                    
                    self?.applySuggestion(
                        suggestion
                    )
                },
                for: .touchUpInside
            )
            
            contentView
                .suggestionStackView
                .addArrangedSubview(chip)
        }
    }
    
    func applySuggestion(
        _ suggestion: ExpressionSuggestion
    ) {
        
        let currentText =
        contentView
            .expressionInputView
            .text
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            )
        
        let newExpression: String
        
        switch suggestion.behavior {
            
        case .replace:
            
            newExpression =
            suggestion.expression
            
        case .append:
            
            if currentText.isEmpty {
                
                newExpression =
                "now \(suggestion.expression)"
                
            } else {
                
                newExpression =
                "\(currentText) \(suggestion.expression)"
            }
        }
        
        contentView
            .expressionInputView
            .setText(
                newExpression
            )
        
        handleExpression(
            newExpression
        )
        
        contentView
            .expressionInputView
            .focus()
        
        animateResultUpdate()
    }
    
    // MARK: Expression Handling
    
    func handleExpression(
        _ text: String
    ) {
        
        let trimmedText =
        text.trimmingCharacters(
            in: .whitespacesAndNewlines
        )
        
        updateAutocomplete(
            for: trimmedText
        )
        
        guard !trimmedText.isEmpty else {
            
            setupInitialState()
            
            contentView
                .expressionInputView
                .clearValidation()
            
            return
        }
        
        let tokenized =
        parser.tokenizer.tokenize(
            input: trimmedText
        )
        
        let grammarResult =
        grammarValidator.validate(
            tokens: tokenized
        )
        
        switch grammarResult {
            
        case .valid:
            
            contentView
                .expressionInputView
                .clearValidation()
            
        case .invalid(let invalidToken):
            
            contentView
                .expressionInputView
                .showValidationError(
                    range:
                        invalidToken.range
                )
        }
        
        guard
            let result =
                parser.parse(
                    input: trimmedText
                )
        else {
            
            showInvalidExpression(
                trimmedText
            )
            
            return
        }
        
        updateUI(
            with: result,
            input: trimmedText
        )
    }
    
    func updateAutocomplete(
        for input: String
    ) {
        
        let suggestions =
        autocompleteEngine
            .suggestions(
                for: input
            )
        
        contentView
            .autocompleteStackView
            .arrangedSubviews
            .forEach {
                
                $0.removeFromSuperview()
            }
        
        suggestions.forEach {
            suggestion in
            
            let chip = ChipView(
                title: suggestion.title
            )
            
            chip.addAction(
                UIAction {
                    [weak self] _ in
                    
                    self?.applyAutocomplete(
                        suggestion
                    )
                },
                for: .touchUpInside
            )
            
            contentView
                .autocompleteStackView
                .addArrangedSubview(
                    chip
                )
        }
    }
    
    func applyAutocomplete(
        _ suggestion: AutocompleteSuggestion
    ) {
        
        HapticEngine.shared.light()
        
        let currentText = contentView
            .expressionInputView
            .text
        
        let cursorLocation = contentView
            .expressionInputView
            .selectedRange
            .location
        
        let replacement = suggestion.insertText
        
        if let token = parser.tokenizer.tokenAtCursor(
            input: currentText,
            cursor: cursorLocation
        ), token.token.isEditableValue {
            
            let nsText = currentText as NSString
            
            let updatedText = nsText.replacingCharacters(
                in: token.range,
                with: replacement
            )
            
            let newCursor = token.range.location + replacement.count
            
            contentView.expressionInputView.setText(
                updatedText,
                moveCursorToEnd: false
            )
            
            contentView.expressionInputView.setCursor(
                location: newCursor
            )
            
            
            let formatted =
            expressionFormatter
                .format(updatedText)
            
            contentView
                .expressionInputView
                .setText(
                    formatted
                )
            
            handleExpression(
                formatted
            )
            
        } else {
            
            let updatedText = currentText + replacement
            
            contentView.expressionInputView.setText(updatedText)
            
            let formatted =
            expressionFormatter
                .format(updatedText)
            
            contentView
                .expressionInputView
                .setText(
                    formatted
                )
            
            handleExpression(
                formatted
            )
        }
        
        contentView.expressionInputView.focus()
    }
    
    func replaceCurrentToken(
        in text: String,
        with replacement: String
    ) -> String {
        
        guard !text.isEmpty else {
            return replacement
        }
        
        let pattern =
        #"[a-zA-Z0-9]+$"#
        
        guard
            let regex =
                try? NSRegularExpression(
                    pattern: pattern
                )
        else {
            return text + replacement
        }
        
        let nsString =
        text as NSString
        
        let range = NSRange(
            location: 0,
            length: nsString.length
        )
        
        guard
            let match =
                regex.firstMatch(
                    in: text,
                    options: [],
                    range: range
                )
        else {
            return text + replacement
        }
        
        return nsString.replacingCharacters(
            in: match.range,
            with: replacement
        )
    }
    
    func normalizeExpression() {
        
        let currentText =
        contentView
            .expressionInputView
            .text
        
        let formatted =
        expressionFormatter
            .format(currentText)
        
        guard formatted != currentText
        else {
            return
        }
        
        contentView
            .expressionInputView
            .setText(
                formatted,
                moveCursorToEnd: true
            )
        
        handleExpression(
            formatted
        )
    }
    
    // MARK: Update UI
    func updateUI(
        with result: ExpressionResult,
        input: String
    ) {
        
        HapticEngine.shared.success()
        
        saveHistoryDebounced(
            expression: input,
            result: result.formattedTime
        )
        
        let model =
        ResultViewModel(
            
            timeText:
                result.formattedTime,
            
            dateText:
                result.formattedDate,
            
            expressionText:
                input
        )
        
        contentView
            .resultCardView
            .configure(
                with: model,
                animated: true
            )
        
        
        contentView
            .breakdownContainerView
            .configure(
                items: [
                    
                    BreakdownItem(
                        title: "Input",
                        value: input
                    ),
                    
                    BreakdownItem(
                        title: "Result",
                        value: result.formattedTime
                    ),
                    
                    BreakdownItem(
                        title: "Date",
                        value: result.formattedDate
                    ),
                    
                    BreakdownItem(
                        title: "Timezone",
                        value: TimeZone.current.identifier
                    )
                ]
            )
        
        animateResultUpdate()
    }
    
    // MARK: Invalid State
    
    func showInvalidExpression(
        _ input: String
    ) {
        
        let model =
        ResultViewModel(
            
            timeText: "--:--",
            
            dateText:
                "Invalid Expression",
            
            expressionText:
                input
        )
        
        contentView
            .resultCardView
            .configure(
                with: model,
                animated: true
            )
        
        animateInvalidResult()
        
        HapticEngine.shared.warning()
    }
}

// MARK: Animation
extension CalculatorViewController {
    func animateInvalidResult() {
        
        let view =
        contentView.resultCardView
        
        UIView.animate(
            withDuration: 0.05,
            animations: {
                
                view.transform =
                CGAffineTransform(
                    translationX: -4,
                    y: 0
                )
            },
            completion: { _ in
                
                UIView.animate(
                    withDuration: 0.05,
                    animations: {
                        
                        view.transform =
                        CGAffineTransform(
                            translationX: 4,
                            y: 0
                        )
                    },
                    completion: { _ in
                        
                        UIView.animate(
                            withDuration: 0.05
                        ) {
                            
                            view.transform =
                                .identity
                        }
                    }
                )
            }
        )
    }
    
    
    // MARK: Animation
    
    func animateResultUpdate() {
        
        UIView.animate(
            withDuration: 0.12,
            animations: {
                
                self.contentView
                    .resultCardView
                    .transform =
                CGAffineTransform(
                    scaleX: 0.985,
                    y: 0.985
                )
                
                self.contentView
                    .resultCardView
                    .alpha = 0.94
            },
            completion: { _ in
                
                UIView.animate(
                    withDuration: 0.24,
                    delay: 0,
                    usingSpringWithDamping: 0.72,
                    initialSpringVelocity: 0.5
                ) {
                    
                    self.contentView
                        .resultCardView
                        .transform =
                        .identity
                    
                    self.contentView
                        .resultCardView
                        .alpha = 1
                }
            }
        )
    }
    
    func scrollToEditor() {
        
        let targetFrame =
        contentView
            .expressionInputView
            .frame
        
        contentView
            .scrollView
            .scrollRectToVisible(
                targetFrame.insetBy(
                    dx: 0,
                    dy: -24
                ),
                animated: true
            )
    }
}

// MARK: History
extension CalculatorViewController {
    func saveHistoryDebounced(
        expression: String,
        result: String
    ) {
        
        guard !isRestoringHistory
        else {
            return
        }
        
        historySaveWorkItem?.cancel()
        
        let workItem =
        DispatchWorkItem {
            [weak self] in
            
            self?.historyStore.save(
                expression: expression,
                result: result
            )
            
            self?.reloadAllSections()
        }
        
        historySaveWorkItem =
        workItem
        
        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.8,
            execute: workItem
        )
    }
    
}

// MARK: Favorites + History
extension CalculatorViewController {
    
    func reloadAllSections() {

        reloadFavorites()

        reloadHistory()
    }
    
    func reloadFavorites() {
        
        let records =
        historyStore.fetchPinned()
        
        contentView
            .favoritesSectionView
            .configure(
                title: "Favorites",
                records: records
            )
    }
    
    func reloadHistory() {
        
        let records =
        historyStore.fetchRecent()
        
        contentView
            .historySectionView
            .configure(
                title: "Recent",
                records: records
            )
    }
    
    func handleSelectRecord(
        _ record: HistoryRecord
    ) {

        HapticEngine.shared.light()

        isRestoringHistory = true

        scrollToEditor()

        contentView
            .expressionInputView
            .setText(
                record.expression
            )

        handleExpression(
            record.expression
        )

        DispatchQueue.main.async {
            [weak self] in

            self?.isRestoringHistory =
                false
        }
    }
    
    func handleDeleteRecord(
        _ record: HistoryRecord
    ) {

        historyStore.delete(
            record
        )

        reloadAllSections()
    }
    
    func handleTogglePin(
        _ record: HistoryRecord
    ) {

        historyStore.togglePin(
            record
        )

        reloadAllSections()
    }
}
