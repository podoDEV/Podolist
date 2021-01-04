
import UIKit
import Core
import Services

final class PriorityButton: UIButton {

  var priority: Priority = .medium
  var isSelectedButton: Bool = false {
    didSet {
      updateUI()
    }
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupSubviews()
  }
  
  init(priority: Priority) {
    super.init(frame: .zero)
    self.priority = priority
    setupSubviews()
  }

  func setupSubviews() {
    backgroundColor = .backgroundColor2
    setTitle(priority.toString(), for: .normal)
    setTitleColor(.white, for: .normal)
    titleLabel?.font = .preferredFont(type: .notoSansMedium, size: 10)
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = 15
    layer.masksToBounds = true
  }

  func updateUI() {
    if isSelectedButton {
      backgroundColor = priority.backgroundColor()
    } else {
      backgroundColor = .backgroundColor2
    }
  }
}
