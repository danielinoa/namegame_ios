//
//  FaceButton.swift
//  NameGame
//
//  Copyright © 2016 WillowTree Apps. All rights reserved.
//

import UIKit

final class FaceButton: UIButton {

    var id: Int = 0
    var tintView: UIView?

    func loadImageFromURL(url: String) {
        guard let imageURL = URL(string: url) else {
            preconditionFailure("Invalid image link")
        }
        URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) -> Void in
            let image = UIImage(data: data!)
            DispatchQueue.main.async { () -> Void in
                self.setBackgroundImage(image, for: UIControlState())
            }
        }).resume()
    }

    override func layoutSubviews() {
        if let tintView = self.tintView {
            tintView.frame = self.bounds
        }
        super.layoutSubviews()
    }

    func animateDisplayName() {
        setTitleColor(.white, for: UIControlState())
        UIView.animate(withDuration: 0.5, animations: {
            self.titleLabel?.alpha = 1.0
        })
    }

    func hideName() {
        setTitleColor(.clear, for: UIControlState())
        titleLabel!.alpha = 0.0
    }



    func addTint(_ color: UIColor) {
        if self.tintView == nil {
            let tintView = UIView(frame: self.bounds)
            tintView.alpha = 0.0
            tintView.backgroundColor = color
            self.addSubview(tintView)
            self.addSubview(self.titleLabel!)
            self.tintView = tintView
        }

        UIView.animate(withDuration: 0.5, animations: {
            self.tintView!.alpha = 0.3
        })
    }

    func removeTint() {
        if let tintView = self.tintView {
            tintView.removeFromSuperview()
        }
    }

}
