//
//  CarDetailTableViewCell.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/27/22.
//

import SnapKit

class CarDetailTableViewCell: UITableViewCell {
    // MARK: - Subviews

    private let carDetailView: CarDetailView = .init()

    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .gOrange
        return view
    }()

    // MARK: - Initializer

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        contentView.addSubview(carDetailView)
        contentView.addSubview(separatorView)

        carDetailView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview()
        }

        separatorView.snp.makeConstraints {
            $0.height.equalTo(4)
            $0.top.equalTo(carDetailView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup

extension CarDetailTableViewCell {
    func setup(collapsedContent: CarDetailCollapsedCellContent) {
        carDetailView.setup(collapsedContent: collapsedContent)
        separatorView.isHidden = collapsedContent.isLastCell
    }
}
