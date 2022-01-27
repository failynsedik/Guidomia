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
        let leftBarButtonItem = UIBarButtonItem(title: "Guidomia", style: .plain, target: nil, action: nil)
        leftBarButtonItem.tintColor = .white
        navigationItem.leftBarButtonItem = leftBarButtonItem

        let rightBarButtonItem = UIBarButtonItem(title: "⠇", style: .plain, target: nil, action: nil)
        rightBarButtonItem.tintColor = .white
        navigationItem.rightBarButtonItem = rightBarButtonItem

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .gOrange
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }

    private func setupViews() {
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
    func tableView(_: UITableView, didSelectRowAt _: IndexPath) {
        // Do nothing for now...
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CarDetailTableViewCell.reuseIdentifier, for: indexPath) as? CarDetailTableViewCell,
           let content = viewModel.getCarDetailCollapsedCellContent(at: indexPath.row)
        {
            cell.setup(collapsedContent: content)
            return cell
        }

        return UITableViewCell()
    }
}
