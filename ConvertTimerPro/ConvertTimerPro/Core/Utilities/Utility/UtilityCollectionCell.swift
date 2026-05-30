//
//  UtilityCollectionCell.swift
//  ConvertTimerPro
//
//  Created by Mac Mini on 30/5/26.
//

import UIKit
import SnapKit
import Then

final class UtilityCollectionCell:
    UICollectionViewCell {

    static let reuseIdentifier =
        "UtilityCollectionCell"

    private let cardView =
        UtilityCardView()

    override init(
        frame: CGRect
    ) {

        super.init(
            frame: frame
        )

        contentView.addSubview(
            cardView
        )

        cardView.snp.makeConstraints {

            $0.edges.equalToSuperview()
        }
    }

    required init?(
        coder: NSCoder
    ) {

        fatalError(
            "init(coder:) has not been implemented"
        )
    }

    func configure(
        item: UtilityItem
    ) {

        cardView.configure(
            item: item
        )
    }
}
