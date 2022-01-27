//
//  CarDetailView.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/27/22.
//

import UIKit

final class CarDetailView: UIView {
    // MARK: - Subviews

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(rgb: 0x000000, alpha: 0.45)
        label.numberOfLines = 0
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = UIColor(rgb: 0x000000, alpha: 0.45)
        label.numberOfLines = 0
        return label
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .gOrange
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}

// MARK: - UI Initial Setup

extension CarDetailView {
    private func setupViews() {
        backgroundColor = .gLightGray

        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(ratingLabel)

        imageView.snp.makeConstraints {
            $0.width.equalTo(126)
            $0.height.equalTo(64)
            $0.top.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(16).priority(.medium)
        }

        nameLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(16)
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.trailing.equalTo(nameLabel)
        }

        ratingLabel.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(nameLabel)
            $0.bottom.equalToSuperview().inset(16).priority(.high)
        }
    }
}

// MARK: - UI Setup

extension CarDetailView {
    func setup(collapsedContent: CarDetailCollapsedCellContent) {
        imageView.image = UIImage(named: collapsedContent.imageName)
        nameLabel.text = collapsedContent.name
        priceLabel.text = collapsedContent.price
        ratingLabel.text = collapsedContent.rating
    }
}
