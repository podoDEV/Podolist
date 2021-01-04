
import UIKit
import Core
import Services

final class PodoWritePriorityView: BaseView {

  weak var delegate: WriteViewDelegate?

  @IBOutlet weak var titleLabel: UILabel! {
    didSet {
      titleLabel.text = "write.priority".localized
      titleLabel.textColor = .appColor1
      titleLabel.font = .preferredFont(type: .notoSansMedium, size: 11)
    }
  }

  @IBOutlet weak var priorityView: PriorityView! {
    didSet {
      priorityView.backgroundColor = .clear
      priorityView.delegate = self
    }
  }

  func update(_ priority: Priority?) {
    priorityView.update(priority)
  }
}

extension PodoWritePriorityView: PriorityViewDelegate {

  func didChangedPriority(priority: Priority) {
    delegate?.didChangedPriority(priority: priority)
  }
}
