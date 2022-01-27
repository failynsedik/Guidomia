//
//  CarFilterTableViewHeaderView.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/27/22.
//

import SnapKit

final class CarFilterTableViewHeaderView: UITableViewHeaderFooterView {
    private let carFilterView: CarFilterView = .init()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        contentView.addSubview(carFilterView)
        carFilterView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        carFilterView.layer.cornerRadius = 8.0
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
