
import UIKit
import Core
import Services

protocol WriteViewDelegate: class {
  func textFieldDidChange(text: String)
  func didChangedPriority(priority: Priority)
  func didChangedDate(date: Date)
  func didTappedDetail()
  func didTappedCreate()
  func didTappedEdit()
}

final class TodoWriteView: BaseView {

  private let titleView = PodoWriteTitleView().loadNib() as! PodoWriteTitleView
  private let priorityView = PodoWritePriorityView().loadNib() as! PodoWritePriorityView
  private let calendarView = PodoWriteCalendarView().loadNib() as! PodoWriteCalendarView

  weak var delegate: WriteViewDelegate? {
    didSet {
      titleView.delegate = delegate
      priorityView.delegate = delegate
      calendarView.delegate = delegate
    }
  }

  override func setupSubviews() {
    titleView.backgroundColor = .white
    titleView.layer.cornerRadius = 15
    titleView.clipsToBounds = true
    addSubview(titleView)
    addSubview(priorityView)
    addSubview(calendarView)
  }

  func updateUI() {
    titleView.frame = CGRect(x: 8, y: 8, width: frame.width - 16, height: 32)
    titleView.expanded = false
    priorityView.isHidden = true
    calendarView.isHidden = true
  }

  func updateUIWriting() {
    titleView.frame = CGRect(x: 8, y: 8, width: frame.width - 16, height: 32)
    titleView.expanded = false
  }

  func updateUIToDetail() {
    titleView.frame = CGRect(x: 8, y: 8, width: frame.width - 16, height: 32)
    titleView.expanded = true
    titleView.titleField.resignFirstResponder()
    priorityView.frame = CGRect(x: 8, y: titleView.frame.maxY + 8, width: frame.width - 16, height: 50)
    priorityView.backgroundColor = .clear
    priorityView.isHidden = false
    calendarView.frame = CGRect(x: 8, y: priorityView.frame.maxY + 8, width: frame.width - 16, height: 210)
    calendarView.backgroundColor = .clear
    calendarView.isHidden = false
  }

  func update(_ todo: Todo, mode: WritingMode) {
    titleView.update(todo.title, mode: mode)
    priorityView.update(todo.priority)
    calendarView.update(todo.dueAt)
  }

  override func resignFirstResponder() -> Bool {
    super.resignFirstResponder()
    titleView.titleField.resignFirstResponder()
    return true
  }
}
