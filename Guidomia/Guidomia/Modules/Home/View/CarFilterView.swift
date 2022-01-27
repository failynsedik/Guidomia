//
//  CarFilterView.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/27/22.
//

import SnapKit

final class CarFilterView: UIView {
    // MARK: - Subviews

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Filters"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()

    private let makeTextField: GTextField = {
        let textField = GTextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Any make",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold),
                NSAttributedString.Key.foregroundColor: UIColor.gLightGray,
            ]
        )
        textField.tintColor = .darkGray
        textField.backgroundColor = .white
        textField.clearButtonMode = .whileEditing
        textField.leftPadding = 16
        textField.rightPadding = 24
        return textField
    }()

    private let modelTextField: GTextField = {
        let textField = GTextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "Any model",
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold),
                NSAttributedString.Key.foregroundColor: UIColor.gLightGray,
            ]
        )
        textField.tintColor = .darkGray
        textField.backgroundColor = .white
        textField.clearButtonMode = .whileEditing
        textField.leftPadding = 16
        textField.rightPadding = 24
        return textField
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        makeTextField.addShadow(x: 0, y: 2, blur: 4, color: UIColor.black, shadowOpacity: 0.4)
        makeTextField.layer.cornerRadius = 8.0
        modelTextField.addShadow(x: 0, y: 2, blur: 4, color: UIColor.black, shadowOpacity: 0.4)
        modelTextField.layer.cornerRadius = 8.0
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}

// MARK: - UI Initial Setup

extension CarFilterView {
    private func setupViews() {
        backgroundColor = .gDarkGray

        addSubview(titleLabel)
        addSubview(makeTextField)
        addSubview(modelTextField)

        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(14)
        }

        makeTextField.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(14)
        }

        modelTextField.snp.makeConstraints {
            $0.height.equalTo(36)
            $0.top.equalTo(makeTextField.snp.bottom).offset(16)
            $0.leading.trailing.equalTo(makeTextField)
            $0.bottom.equalToSuperview().inset(24)
        }
    }
}

// MARK: - UI Setup

extension CarFilterView {
    func setup() {}
}
