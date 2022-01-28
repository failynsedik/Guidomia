//
//  CarFilterView.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/27/22.
//

import SnapKit

protocol CarFilterViewDelegate: AnyObject {
    func didFilterMake(_ carFilterView: CarFilterView, make: String)
    func didFilterModel(_ carFilterView: CarFilterView, model: String)
}

final class CarFilterView: UIView {
    weak var delegate: CarFilterViewDelegate?
    private(set) var viewModel = CarFilterViewModel()

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
        textField.returnKeyType = .next
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
        textField.returnKeyType = .done
        textField.leftPadding = 16
        textField.rightPadding = 24
        return textField
    }()

    private let filterPickerView = UIPickerView()

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
        makeTextField.inputView = filterPickerView
        modelTextField.inputView = filterPickerView
        filterPickerView.delegate = self
        filterPickerView.dataSource = self

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

// MARK: - Setup

extension CarFilterView {
    func setup(carMakeList: [String], carModelList: [String]) {
        viewModel.carMakeList = carMakeList
        viewModel.carModelList = carModelList
    }
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
        case makeTextField:
            viewModel.activeFilterFieldType = .make

        case modelTextField:
            viewModel.activeFilterFieldType = .model

        default: return
        }
    }
}

// MARK: - UIPickerViewDelegate

extension CarFilterView: UIPickerViewDelegate {
    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        viewModel.pickerViewTitle(for: row)
    }

    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        switch viewModel.activeFilterFieldType {
        case .make:
            let make = viewModel.pickerViewTitle(for: row)
            makeTextField.text = make
            delegate?.didFilterMake(self, make: make)

        case .model:
            let model = viewModel.pickerViewTitle(for: row)
            modelTextField.text = model
            delegate?.didFilterModel(self, model: model)

        default:
            return
        }

        endEditing(true)
    }
}

// MARK: - UIPickerViewDataSource

extension CarFilterView: UIPickerViewDataSource {
    func numberOfComponents(in _: UIPickerView) -> Int {
        1
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        viewModel.pickerViewNumberOfRows()
    }
}
