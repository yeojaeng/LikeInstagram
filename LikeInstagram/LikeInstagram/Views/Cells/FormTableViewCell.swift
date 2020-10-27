//
//  FormTableViewCell.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/25.
//

import UIKit

// textField return시 ViewController에게 데이터를 전달하기 위한 델리게이트 패턴
protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updateModel: EditProfileFormModel)
}

class FormTableViewCell: UITableViewCell {

    // MARK: - Properties

    static let identifier: String = "FormTableViewCell"

    private var model: EditProfileFormModel?
    // 사용자가 return키 터치시 델리게이트를 통해 value updating
    public weak var delegate: FormTableViewCellDelegate?

    private let formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()

    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()

    // MARK: - Methods

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        field.delegate = self
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        // set frame UI Component
        super.layoutSubviews()
        formLabel.frame = CGRect(x: 5,
                                 y: 0,
                                 width: contentView.width / 3,
                                 height: contentView.height)

        field.frame = CGRect(x: formLabel.right + 5,
                             y: 0,
                             width: contentView.width - 10 - formLabel.width,
                             height: contentView.height)
    }

    override func prepareForReuse() {
        // 재사용시 객체 프로퍼티 초기화
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }

    public func configure(with model: EditProfileFormModel) {
        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
}

// MARK: - TextField Delgate Methods
extension FormTableViewCell: UITextFieldDelegate {

    /// textField return시 키보드 내리기
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.value = textField.text
        guard let model = model else {
            return true
        }
        // 델리게이트 메서드 호출
        delegate?.formTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }
}
