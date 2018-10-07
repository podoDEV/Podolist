//
//  UIView+Additions.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

import UIKit

extension UIView {

    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }

    func layoutInsets() -> UIEdgeInsets {
        var layoutInset: UIEdgeInsets = .zero
        if #available(iOS 11.0, *) {
            layoutInset = (UIApplication.shared.keyWindow?.safeAreaInsets)!
            if layoutInset.top > 20 {
                layoutInset.top -= 20
            }
        }
        layoutInset.top += 20
        return layoutInset
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
