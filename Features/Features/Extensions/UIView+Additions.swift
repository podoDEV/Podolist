
import UIKit

public extension UIView {
  func loadNib() -> UIView {
    let bundle = Bundle(for: type(of: self))
    let nibName = type(of: self).description().components(separatedBy: ".").last!
    let nib = UINib(nibName: nibName, bundle: bundle)
    return nib.instantiate(withOwner: self, options: nil).first as! UIView
  }

  func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
    let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
    let mask = CAShapeLayer()
    mask.path = path.cgPath
    self.layer.mask = mask
  }

  func findViewController() -> UIViewController? {
    if let nextResponder = self.next as? UIViewController {
      return nextResponder
    } else if let nextResponder = self.next as? UIView {
      return nextResponder.findViewController()
    } else {
      return nil
    }
  }
}

extension UIView {

  func asImage() -> UIImage? {
    if #available(iOS 10.0, *) {
      let renderer = UIGraphicsImageRenderer(bounds: bounds)
      return renderer.image { rendererContext in
        layer.render(in: rendererContext.cgContext)
      }
    } else {
      UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0)
      defer { UIGraphicsEndImageContext() }
      guard let currentContext = UIGraphicsGetCurrentContext() else {
        return nil
      }
      self.layer.render(in: currentContext)
      return UIGraphicsGetImageFromCurrentImageContext()
    }
  }
}
