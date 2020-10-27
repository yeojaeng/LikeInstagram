//
//  PhotoCollectionViewCell.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/25.
//

import UIKit

import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier: String = "PhotoCollectionViewCell"

    private let photoImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    // MARK: - Method

    override func layoutSubviews() {
        super.layoutSubviews()
        photoImageView.frame = contentView.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(photoImageView)
        contentView.clipsToBounds = true
        accessibilityLabel = "User's post image"
        accessibilityHint = "Double Tap to open post"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func configure(with model: UserPost) {
        let thumbnailURL: URL = model.thumbnailImage
//        let task = URLSession.shared.dataTask(with: thumbnailURL) { [weak self] (data, response, error) in
//            guard let self = self, let data = data else { return }
//            self.photoImageView.image = UIImage(data: data)
//        }
        photoImageView.sd_setImage(with: thumbnailURL, completed: nil)
    }

    public func configure(with imageName: String) {
        photoImageView.image = UIImage(named: imageName)
    }
}
