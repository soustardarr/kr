//
//  ViewController.swift
//  Timer
//
//  Created by Ruslan Kozlov on 16.04.2024.
//

import UIKit
import Combine

class ToDoListViewController: UIViewController {

    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()


    private var myTasks: [MyTask] = []
    private var cancellable: Set<AnyCancellable> = []
    private var viewModel: ToDoViewModel?


    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ToDoViewModel()
        obtainTasks()
        view.backgroundColor = .green
        setupNavigationBar()
        setupLayout()
    }

    private func obtainTasks() {
        viewModel?.taskManager.$myTasks.sink { [weak self ] array in
            self?.myTasks = array
            self?.tableView.reloadData()
        }.store(in: &cancellable)

    }

    private func setupNavigationBar() {
        let action = UIAction { _ in self.navigationController?.pushViewController(DetailController(), animated: true) }
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add, primaryAction: action)
    }

    private func setupLayout() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyTaskCell.self, forCellReuseIdentifier: MyTaskCell.reuseIdentifier)

        NSLayoutConstraint.activate([

            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)

        ])
    }


}


extension ToDoListViewController: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myTasks.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTaskCell.reuseIdentifier, for: indexPath) as? MyTaskCell
        cell?.configure(with: myTasks[indexPath.row])
        return cell ?? UITableViewCell()

    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
        if let _ = tableView.cellForRow(at: indexPath) as? MyTaskCell {
            viewModel?.addRequest(task: myTasks[indexPath.row])
           }
       }


}
