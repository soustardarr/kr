//
//  DetailController.swift
//  Timer
//
//  Created by Ruslan Kozlov on 16.04.2024.
//

import UIKit

class DetailController: UIViewController {

    var titleTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Задача"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.borderStyle = .roundedRect
        return textField
    }()

    var durationPicker: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()

    var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Добавить", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.addTarget(nil, action: #selector(addTask), for: .touchUpInside)
        return button
    }()



    private var viewModel: DetailViewModel?

    var durations = [1,5,10,15,25]

    var selectedDuration: Int?

    private func setupPickerView() {
        durationPicker.dataSource = self
        durationPicker.delegate = self
    }



    @objc private func addTask() {
        guard let title = titleTextField.text, !title.isEmpty else {
            return
        }
        guard let selectedDuration = selectedDuration else {
            return
        }
        let selectedTimeInterval = TimeInterval(selectedDuration * 60)
        let myTask = MyTask(title: title, duration: selectedTimeInterval, isCompleted: false)
        viewModel?.addTask(myTask)
        navigationController?.popViewController(animated: true)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        viewModel?.printTask()

    }

    private func setup() {
        setupLayout()
        setupPickerView()
        viewModel = DetailViewModel()
    }

    private func setupLayout() {
        view.backgroundColor = .systemMint
        view.addSubview(titleTextField)
        view.addSubview(durationPicker)
        view.addSubview(addButton)

        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

            durationPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            durationPicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),

            addButton.topAnchor.constraint(equalTo: durationPicker.bottomAnchor),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)


        ])


    }
}

extension DetailController: UIPickerViewDataSource, UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return durations.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let duration = durations[row]
        return "\(duration) мин"
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDuration = durations[row]
    }

}
