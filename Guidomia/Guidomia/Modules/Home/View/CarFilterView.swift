//
//  CarFilterView.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/27/22.
//

import SnapKit

protocol CarFilterViewDelegate: AnyObject {
    func didTapMakeTextField()
    func didTapModelTextField()
    func didFilterMake(_ carFilterView: CarFilterView, make: String)
    func didFilterModel(_ carFilterView: CarFilterView, model: String)
}

final class CarFilterView: UIView {
    weak var delegate: CarFilterViewDelegate?

    // MARK: - Subviews

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Filters"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .white
        return label
    }()

    let makeTextField: GTextField = {
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
        textField.returnKeyType = .next
        textField.leftPadding = 16
        textField.rightPadding = 24
        return textField
    }()

    let modelTextField: GTextField = {
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
        textField.returnKeyType = .done
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

        makeTextField.delegate = self
        modelTextField.delegate = self
        makeTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        modelTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

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

// MARK: - UITextFieldDelegate

extension CarFilterView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        if textField == makeTextField {
            modelTextField.becomeFirstResponder()
        }

        return true
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        switch textField {
        case makeTextField:
            delegate?.didFilterMake(self, make: textField.text ?? "")

        case modelTextField:
            delegate?.didFilterModel(self, model: textField.text ?? "")

        default: return
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case makeTextField: delegate?.didTapMakeTextField()
        case modelTextField: delegate?.didTapModelTextField()
        default: return
        }
    }
}
