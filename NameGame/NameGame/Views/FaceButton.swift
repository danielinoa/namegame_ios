//
//  FaceButton.swift
//  NameGame
//
//  Copyright © 2016 WillowTree Apps. All rights reserved.
//

import UIKit

final class FaceButton: UIButton {
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    private func configure() {
        tintView.frame = bounds
        tintView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(tintView, at: 0)
    }
    
    func configure(with person: Person) {
        loadImageFromURL(url: person.imageUrl)
        setTitle(person.name, for: .normal)
    }
    
    // MARK: - Image

    func loadImageFromURL(url: String) {
        guard let imageURL = URL(string: url) else {
            preconditionFailure("Invalid image link")
        }
        URLSession.shared.dataTask(with: imageURL, completionHandler: { (data, response, error) -> Void in
            let image = UIImage(data: data!)
            DispatchQueue.main.async { () -> Void in
                self.setBackgroundImage(image, for: .normal)
            }
        }).resume()
    }

    // MARK: - Label
    
    func animateDisplayName() {
        setTitleColor(.white, for: .normal)
        UIView.animate(withDuration: 0.5) {
            self.titleLabel?.alpha = 1.0
        }
    }

    func hideName() {
        setTitleColor(.clear, for: .normal)
        titleLabel?.alpha = 0.0
    }
    
    // MARK: - Tint

    private let tintView: UIView = {
        let view = UIView()
        view.alpha = 0
        return view
    }()
    
    func setTint(color: UIColor) {
        tintView.backgroundColor = color
        UIView.animate(withDuration: 0.5) {
            self.tintView.alpha = 0.3
        }
    }

    func removeTint() {
        tintView.alpha = 0
    }

}
