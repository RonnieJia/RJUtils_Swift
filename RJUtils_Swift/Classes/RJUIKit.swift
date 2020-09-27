//
//  RJUIKit.swift
//
//  Created by bono.
//

import UIKit

public func RJView(frame: CGRect = .zero, backgroundColor: UIColor = .white) -> UIView {
    let view = UIView(frame: frame)
    view.backgroundColor = backgroundColor
    return view
}

public func RJLabel(
    frame rect: CGRect = .zero,
    textColor: UIColor = .black,
    font: UIFont = RJFont(size: 14),
    textAlignment: NSTextAlignment = .left,
    text: String = ""
) -> UILabel {
    let label = UILabel(frame: rect)
    label.textColor = textColor
    label.font = font
    label.textAlignment = textAlignment
    if text.isEmpty {
        label.text = text
    }
    return label
}

public func RJButton(
    frame rect: CGRect = .zero,
    image: UIImage?,
    selectedImage: UIImage?,
    backgroundImage: UIImage?,
    backgroundColor: UIColor = .white,
    textColor: UIColor = .black,
    font: UIFont = RJFont(),
    title: String?
) -> UIButton {
    let button = UIButton(type: .custom)
    button.frame = rect
    if let image = image {
        button.setImage(image, for: .normal)
    }
    if let selectedImage = selectedImage {
        button.setImage(selectedImage, for: .selected)
    }
    if let backgroundImage = backgroundImage {
        button.setBackgroundImage(backgroundImage, for: .normal)
    }
    button.backgroundColor = backgroundColor
    button.titleLabel?.font = font
    button.setTitleColor(textColor, for: .normal)
    if let text = title {
        button.setTitle(text, for: .normal)
    }
    return button
}

public func RJImageView(frame rect: CGRect = .zero, image: UIImage?) -> UIImageView {
    let imageView = UIImageView(frame: rect)
    if let image = image {
        imageView.image = image
    }
    return imageView
}

public func RJTextField(
    frame rect: CGRect = .zero,
    textColor: UIColor?,
    font: UIFont?,
    isSecure: Bool = false,
    keyboardType: UIKeyboardType = .default,
    placeholder: String = "",
    text: String?
) -> UITextField {
    let textField = UITextField(frame: rect)
    if let textColor = textColor {
        textField.textColor = textColor
    }
    if let font = font {
        textField.font = font
    }
    textField.isSecureTextEntry = isSecure
    textField.clearButtonMode = .whileEditing
    textField.keyboardType = keyboardType
    textField.placeholder = placeholder
    textField.text = text
    return textField
}

func RJTableView(
    frame rect: CGRect = .zero,
    style: UITableViewStyle = .plain
) -> UITableView {
    let tableView = UITableView(frame: rect, style: style)
    tableView.tableFooterView = UIView()
    tableView.tableHeaderView = UIView()
    tableView.estimatedRowHeight = 44.0
    if #available(iOS 11.0, *) {
        tableView.contentInsetAdjustmentBehavior = .never
    }
    return tableView
}



