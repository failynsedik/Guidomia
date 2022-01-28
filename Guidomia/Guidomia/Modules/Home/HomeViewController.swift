//
//  HomeViewController.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/27/22.
//

import UIKit

final class HomeViewController: UIViewController {
    private let viewModel = HomeViewModel()

    // MARK: - Subview

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        let clearView = UIView()
        clearView.backgroundColor = .clear
        tableView.tableHeaderView = clearView
        tableView.tableFooterView = clearView
        tableView.keyboardDismissMode = .interactive
        tableView.register(CarHeaderTableViewCell.self, forCellReuseIdentifier: CarHeaderTableViewCell.reuseIdentifier)
        tableView.register(CarDetailTableViewCell.self, forCellReuseIdentifier: CarDetailTableViewCell.reuseIdentifier)
        return tableView
    }()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNav()
        setupViews()
    }
}

// MARK: - UI Initial Setup

extension HomeViewController {
    private func setupNav() {
        let leftBarButtonItem = UIBarButtonItem(title: "GUIDOMIA", style: .plain, target: nil, action: nil)
        leftBarButtonItem.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont(name: "STStencil", size: 24)!,
            ],
            for: .disabled
        )
        navigationItem.leftBarButtonItem = leftBarButtonItem
        navigationItem.leftBarButtonItem?.isEnabled = false

        let rightBarButtonItem = UIBarButtonItem(title: "☰", style: .plain, target: nil, action: nil)
        rightBarButtonItem.tintColor = .white
        rightBarButtonItem.setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.white,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 32, weight: .bold),
            ],
            for: .disabled
        )
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.rightBarButtonItem?.isEnabled = false

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gOrange
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }

    private func setupViews() {
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Do not proceed if not on the car list section
        // Do not proceed if user clicked the same cell
        guard indexPath.section == HomeSection.carList.rawValue,
              indexPath.row != viewModel.expandedCellRow
        else { return }

        let previouslyExpandedRow = viewModel.expandedCellRow
        viewModel.expandedCellRow = indexPath.row

        tableView.reloadRows(
            at: [
                IndexPath(row: previouslyExpandedRow, section: HomeSection.carList.rawValue),
                IndexPath(row: viewModel.expandedCellRow, section: HomeSection.carList.rawValue),
            ],
            with: .automatic
        )
    }

    func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch HomeSection(rawValue: indexPath.section) {
        case .header: return 250
        case .carList: return UITableView.automaticDimension
        default: return UITableView.automaticDimension
        }
    }

    func tableView(_: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch HomeSection(rawValue: section) {
        case .header: return CGFloat.leastNormalMagnitude // FIX: Space above tableview
        case .carList: return UITableView.automaticDimension
        default: return CGFloat.leastNormalMagnitude
        }
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch HomeSection(rawValue: section) {
        case .header: return UIView()
        case .carList:
            let headerView = CarFilterTableViewHeaderView()
            headerView.carFilterView.delegate = self
            headerView.carFilterView.makeTextField.inputView = filterPickerView
            headerView.carFilterView.modelTextField.inputView = filterPickerView
            return headerView

        default: return UIView()
        }
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        HomeSection.allCases.count
    }

    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch HomeSection(rawValue: section) {
        case .header: return 1
        case .carList: return viewModel.numberOfRows()
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch HomeSection(rawValue: indexPath.section) {
        case .header:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CarHeaderTableViewCell.reuseIdentifier, for: indexPath) as? CarHeaderTableViewCell {
                return cell
            }

            return UITableViewCell()

        case .carList:
            if let cell = tableView.dequeueReusableCell(withIdentifier: CarDetailTableViewCell.reuseIdentifier, for: indexPath) as? CarDetailTableViewCell {
                let row = indexPath.row

                if viewModel.expandedCellRow == row {
                    // Expanded cell
                    if let content = viewModel.getCarDetailExpandedCellContent(at: row) {
                        cell.setup(expandedContent: content)
                        return cell
                    } else {
                        return UITableViewCell()
                    }
                } else if let content = viewModel.getCarDetailCollapsedCellContent(at: row) {
                    // Collapsed cell
                    cell.setup(collapsedContent: content)
                    return cell
                } else {
                    return UITableViewCell()
                }
            }

            return UITableViewCell()

        default:
            return UITableViewCell()
        }
    }
}

// MARK: - UIPickerViewDelegate

extension HomeViewController: UIPickerViewDelegate {
    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent _: Int) -> String? {
        viewModel.pickerViewTitle(for: row)
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow _: Int, inComponent _: Int) {
        viewModel.filterCars()
        pickerView.isHidden = true
    }
}

// MARK: - UIPickerViewDataSource

extension HomeViewController: UIPickerViewDataSource {
    func numberOfComponents(in _: UIPickerView) -> Int {
        1
    }

    func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        viewModel.pickerViewNumberOfRows()
    }
}

// MARK: - CarFilterViewDelegate

extension HomeViewController: CarFilterViewDelegate {
    func didTapMakeTextField() {
        viewModel.activeFilterFieldType = .make
        filterPickerView.isHidden = false
    }

    func didTapModelTextField() {
        viewModel.activeFilterFieldType = .model
        filterPickerView.isHidden = false
    }

    func didFilterMake(_: CarFilterView, make: String) {
        viewModel.didFilterMake(make: make)
        tableView.reloadData()
    }

    func didFilterModel(_: CarFilterView, model: String) {
        viewModel.didFilterModel(model: model)
        tableView.reloadData()
    }
}
