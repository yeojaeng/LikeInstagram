//
//  Extensions.swift
//  LikeInstagram
//
//  Created by Yeojaeng on 2020/10/22.
//

import UIKit

// MARK: - UIView Extension

extension UIView {

    public var width: CGFloat {
        return frame.size.width
    }

    public var height: CGFloat {
        return frame.size.height
    }

    public var top: CGFloat {
        return frame.origin.y
    }

    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }

    public var left: CGFloat {
        return frame.origin.x
    }

    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
}

// MARK: - String Extension

extension String {
    func makeSafeEmail() -> String {
        return self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
    }
}

// MARK: - UIViewController Extension

extension UIViewController {

    func showAlert(title: String, message: String) {
        let alertVC: UIAlertController = UIAlertController(title: title,
                                                           message: message,
                                                           preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK",
                                        style: .cancel,
                                        handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}
