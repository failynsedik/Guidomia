//
//  CarHeaderTableViewCell.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/27/22.
//

import SnapKit

final class CarHeaderTableViewCell: UITableViewCell {
    // MARK: - Subviews

    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Tacoma")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let headingLabel: UILabel = {
        let label = UILabel()
        label.text = "Tacoma 2021"
        label.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    private let subheadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Get yours now"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        backgroundColor = .white

        contentView.addSubview(headerImageView)
        contentView.addSubview(headingLabel)
        contentView.addSubview(subheadingLabel)

        headerImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        headingLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.bottom.equalTo(subheadingLabel.snp.top).offset(-4)
        }

        subheadingLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.bottom.equalToSuperview().inset(24)
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
