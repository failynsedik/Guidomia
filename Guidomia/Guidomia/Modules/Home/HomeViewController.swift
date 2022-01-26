//
//  HomeViewController.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/27/22.
//

import UIKit

class HomeViewController: UIViewController {
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
    }
}
