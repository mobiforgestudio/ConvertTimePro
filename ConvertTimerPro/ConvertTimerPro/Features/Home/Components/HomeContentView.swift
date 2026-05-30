//
//  HomeContentView.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class HomeContentView: BaseView {

    var onUtilitySelected: ((UtilityItem) -> Void)?

    let recentSection = UtilitySectionView()

    private let scrollView = UIScrollView()

    private let contentView = UIView()

    private let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 24
    }

    private let titleLabel = UILabel().then {
        $0.text = "ConvertTimer Pro"
        $0.font = AppFont.largeTitle()
        $0.textColor = AppColor.Text.primary
    }

    private let subtitleLabel = UILabel().then {
        $0.text = "Time & Productivity Utilities"
        $0.font = AppFont.bodyMedium()
        $0.textColor = AppColor.Text.secondary
    }

    private let countLabel = UILabel().then {
        $0.text = "\(UtilityItem.allCases.count) Utilities Ready"
        $0.font = AppFont.caption()
        $0.textColor = AppColor.Accent.primary
    }

    private let quickActionsTitleLabel = UILabel().then {
        $0.text = "Quick Actions"
        $0.font = AppFont.bodyMedium()
        $0.textColor = AppColor.Text.primary
    }

    let currentTimestampButton = UIButton(type: .system).then {
        $0.setTitle("Current Timestamp", for: .normal)
        $0.setTitleColor(AppColor.Text.primary, for: .normal)
        $0.backgroundColor = AppColor.Surface.card
        $0.layer.cornerRadius = 18
    }

    let today30DaysButton = UIButton(type: .system).then {
        $0.setTitle("Today + 30 Days", for: .normal)
        $0.setTitleColor(AppColor.Text.primary, for: .normal)
        $0.backgroundColor = AppColor.Surface.card
        $0.layer.cornerRadius = 18
    }

    let workdays90Button = UIButton(type: .system).then {
        $0.setTitle("Today + 90 Workdays", for: .normal)
        $0.setTitleColor(AppColor.Text.primary, for: .normal)
        $0.backgroundColor = AppColor.Surface.card
        $0.layer.cornerRadius = 18
    }

    private let tipCard = AppCardView()

    private let tipTitleLabel = UILabel().then {
        $0.text = "Did You Know?"
        $0.font = AppFont.bodyMedium()
        $0.textColor = AppColor.Text.primary
    }

    private let tipDescriptionLabel = UILabel().then {
        $0.text = "Workdays exclude weekends when calculating business dates."
        $0.font = AppFont.caption()
        $0.textColor = AppColor.Text.secondary
        $0.numberOfLines = 0
    }

    override func setupView() {

        backgroundColor = AppColor.Background.primary

        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(countLabel)

        stackView.addArrangedSubview(quickActionsTitleLabel)
        stackView.addArrangedSubview(currentTimestampButton)
        stackView.addArrangedSubview(today30DaysButton)
        stackView.addArrangedSubview(workdays90Button)

        stackView.addArrangedSubview(recentSection)
        stackView.addArrangedSubview(tipCard)

        tipCard.addSubview(tipTitleLabel)
        tipCard.addSubview(tipDescriptionLabel)

        recentSection.onItemSelected = { [weak self] item in
            self?.onUtilitySelected?(item)
        }
    }

    override func setupConstraints() {

        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }

        [
            currentTimestampButton,
            today30DaysButton,
            workdays90Button
        ].forEach {
            $0.snp.makeConstraints {
                $0.height.equalTo(52)
            }
        }

        tipCard.snp.makeConstraints {
            $0.height.equalTo(110)
        }

        tipTitleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }

        tipDescriptionLabel.snp.makeConstraints {
            $0.top.equalTo(tipTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.lessThanOrEqualToSuperview().offset(-16)
        }
    }

    func configureRecent(
        items: [UtilityItem]
    ) {

        recentSection.configure(
            title: "Recent",
            items: items
        )
    }
}
