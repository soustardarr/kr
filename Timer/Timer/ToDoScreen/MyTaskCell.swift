//
//  MyTaskCell.swift
//  Timer
//
//  Created by Ruslan Kozlov on 16.04.2024.
//

import UIKit

class MyTaskCell: UITableViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    let durationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()

    let completedCheckbox: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        button.tintColor = .systemGreen
        button.isUserInteractionEnabled = false
        return button
    }()

    let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Приступить", for: .normal)
        button.tintColor = .systemBlue
        button.isHidden = true
        button.isUserInteractionEnabled = false
        return button
    }()



    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titleLabel)
        contentView.addSubview(durationLabel)
        contentView.addSubview(completedCheckbox)
//        contentView.addSubview(startButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: completedCheckbox.leadingAnchor, constant: -8),

            durationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            durationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            durationLabel.trailingAnchor.constraint(equalTo: completedCheckbox.leadingAnchor, constant: -8),
            durationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),

            completedCheckbox.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            completedCheckbox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            completedCheckbox.widthAnchor.constraint(equalToConstant: 24),
            completedCheckbox.heightAnchor.constraint(equalToConstant: 24),

//            startButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            startButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)

        ])
    }

    func configure(with task: MyTask) {
        titleLabel.text = task.title
        let minutes = Int(task.duration / 60)
        durationLabel.text = "\(minutes) мин"
        if task.isCompleted {
            completedCheckbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
//            startButton.isHidden = false
            completedCheckbox.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



}


extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
