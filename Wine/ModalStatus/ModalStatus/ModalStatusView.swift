//
//  ModalStatusView.swift
//  ModalStatus
//
//  Created by JOFFRE Jean-baptiste on 15/03/2018.
//  Copyright © 2018 JOFFRE Jean-baptiste. All rights reserved.
//

import Foundation
import UIKit

public class ModalStatusView: UIView {
    
    let nibViewName: String = "ModalStatus"
    var contentView: UIView!
    var timer: Timer?
    
    @IBOutlet weak var statusImage: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var subHeadlineLabel: UILabel!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        // For use in Interface Builder
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibViewName, bundle: bundle)
        print(nib.debugDescription)
        self.contentView = nib.instantiate(withOwner: self, options: nil).first as? UIView
        addSubview(contentView)
        
        contentView.center = self.center
        contentView.autoresizingMask = []
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        self.layoutIfNeeded()
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
        
        self.headlineLabel.text = ""
        self.subHeadlineLabel.text = ""
        
        contentView.alpha = 0.0
    }
    
    public func set(headline text: String) -> ModalStatusView {
        self.headlineLabel.text = text
        return self
    }
    
    public func set(subHeadline text: String) -> ModalStatusView {
        self.subHeadlineLabel.text = text
        return self
    }
    
    public func set(modalImage image: UIImage) -> ModalStatusView {
        self.statusImage.image = image
        return self
    }
    
    public override func didMoveToSuperview() {
        self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.15, animations: {
            self.contentView.alpha = 1.0
            self.contentView.transform = CGAffineTransform.identity
        }) { _ in
            self.timer = Timer.scheduledTimer(
                timeInterval: TimeInterval(3.0),
                target: self,
                selector: #selector(self.removeSelf),
                userInfo: nil,
                repeats: false)
        }
    }
    
    @objc private func removeSelf() {
        // Animate removal of view
        UIView.animate(
            withDuration: 0.15,
            animations: {
                self.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                self.contentView.alpha = 0.0
        }) { _ in
            self.removeFromSuperview()
        }
    }
    
}
