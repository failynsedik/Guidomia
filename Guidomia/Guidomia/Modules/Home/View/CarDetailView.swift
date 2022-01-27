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

    private let prosTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Pros :"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor(rgb: 0x000000, alpha: 0.45)
        return label
    }()

    private let consTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cons :"
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.textColor = UIColor(rgb: 0x000000, alpha: 0.45)
        return label
    }()

    private let prosStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()

    private let consStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
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

        // The following are the common subviews and constraints
        // between the collapsed and expanded states

        addSubview(imageView)
        addSubview(nameLabel)
        addSubview(priceLabel)
        addSubview(ratingLabel)

        imageView.snp.makeConstraints {
            $0.width.equalTo(126)
            $0.height.equalTo(64)
            $0.top.leading.equalToSuperview().inset(16)
        }

        nameLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(16)
            $0.leading.equalTo(imageView.snp.trailing).offset(16)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.trailing.equalTo(nameLabel)
        }
    }
}

// MARK: - UI Setup

extension CarDetailView {
    func setup(collapsedContent: CarDetailCollapsedCellContent) {
        // Set content
        imageView.image = UIImage(named: collapsedContent.imageName)
        nameLabel.text = collapsedContent.name
        priceLabel.text = collapsedContent.price
        ratingLabel.text = collapsedContent.rating

        // Remove subviews for expanded cell
        prosTitleLabel.removeFromSuperview()
        prosStackView.removeAllArrangedSubviews()
        prosStackView.removeFromSuperview()
        consTitleLabel.removeFromSuperview()
        consStackView.removeAllArrangedSubviews()
        consStackView.removeFromSuperview()

        // Setup constraints
        ratingLabel.snp.remakeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(nameLabel)
            $0.bottom.equalToSuperview().inset(16)
        }
    }

    func setup(expandedContent: CarDetailExpandedCellContent) {
        // Set content
        imageView.image = UIImage(named: expandedContent.collapsedContent.imageName)
        nameLabel.text = expandedContent.collapsedContent.name
        priceLabel.text = expandedContent.collapsedContent.price
        ratingLabel.text = expandedContent.collapsedContent.rating

        // Reset stackview's configurations
        prosStackView.removeAllArrangedSubviews()
        prosStackView.removeFromSuperview()
        consStackView.removeAllArrangedSubviews()
        consStackView.removeFromSuperview()

        // Add arranged subviews for the stackviews
        for pros in expandedContent.pros {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
            label.attributedText = pros
            label.numberOfLines = 0
            prosStackView.addArrangedSubview(label)
        }

        for cons in expandedContent.cons {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
            label.attributedText = cons
            label.numberOfLines = 0
            consStackView.addArrangedSubview(label)
        }

        // Add subviews for expanded cell
        addSubview(prosTitleLabel)
        addSubview(prosStackView)
        addSubview(consTitleLabel)
        addSubview(consStackView)

        // Setup constraints
        ratingLabel.snp.remakeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(nameLabel)
        }

        prosTitleLabel.snp.remakeConstraints {
            $0.top.equalTo(ratingLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(32)
        }

        prosStackView.snp.remakeConstraints {
            $0.top.equalTo(prosTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(32)
        }

        consTitleLabel.snp.remakeConstraints {
            $0.top.equalTo(prosStackView.snp.bottom).offset(14)
            $0.leading.trailing.equalToSuperview().inset(32)
        }

        consStackView.snp.remakeConstraints {
            $0.top.equalTo(consTitleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(32)
            $0.bottom.equalToSuperview().inset(32)
        }
    }
}
