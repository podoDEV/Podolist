import UIKit

final class TodolistCompressor: NSObject {
  enum State {
    case initial
    case `default`
    case writing
    case expand
    case calendar(show: Bool)
  }
  // MARK: - Constants

  private struct Metric {
    static let topViewHeight = 133.f
    static let monthCalendarHeight = 400.f
    static let writeViewNormalHeight = 50.f
    static let writeViewExpandHeight = 330.f
    static let writeViewTotalHeight = 400.f
  }

  weak var parent: UIView?

  weak var delegate: WriteViewDelegate?
  var safeAreaInset: UIEdgeInsets = .zero

  weak var monthCalendarView: MonthCalendarView?
  weak var monthCalendarHidingView: UIView?
  weak var topView: MainTopView?
  weak var tableView: UITableView?
  weak var writeView: TodoWriteView?
  weak var writeHidingView: UIView?

  var keyboardHeight: CGFloat?

  func setState(_ state: State) {
    switch state {
    case .initial: setInit()
    case .`default`: setDefault()
    case .writing: setWriting()
    case .expand: setExpand()
    case .calendar(let show): show ? showCalendar() : hideCalendar()
    }
  }

  func setInit() {
    guard
      let parent = parent,
      let monthCalendarView = monthCalendarView,
      let monthCalendarHidingView = monthCalendarHidingView,
      let topView = topView,
      let tableView = tableView,
      let writeView = writeView,
      let writeHidingView = writeHidingView
    else { return }

    monthCalendarView.frame = CGRect(
      x: 0,
      y: -Metric.monthCalendarHeight - safeAreaInset.top,
      width: parent.bounds.width,
      height: Metric.monthCalendarHeight + safeAreaInset.top
    )
    monthCalendarHidingView.frame = CGRect(
      x: 0,
      y: 0,
      width: parent.bounds.width,
      height: parent.bounds.height + safeAreaInset.bottom
    )

    topView.frame.size = CGSize(
      width: parent.bounds.width,
      height: Metric.topViewHeight + safeAreaInset.top
    )
    tableView.frame = CGRect(
      x: 0,
      y: topView.frame.maxY,
      width: parent.bounds.width,
      height: parent.bounds.height - topView.frame.height - Metric.writeViewNormalHeight - safeAreaInset.bottom
    )
    writeHidingView.frame = CGRect(
      x: 0,
      y: 0,
      width: parent.bounds.width,
      height: parent.bounds.height + safeAreaInset.bottom
    )
    writeView.frame = normalFrame
  }

  func setDefault() {
    guard
      let parent = parent,
      let monthCalendarHidingView = monthCalendarHidingView,
      let writeView = writeView,
      let writeHidingView = writeHidingView
    else { return }

    parent.bringSubviewToFront(writeView)
    monthCalendarHidingView.isHidden = true
    writeHidingView.isHidden = true
    UIView.animate(withDuration: 0.2) {
      writeView.frame = self.normalFrame
    }
    writeView.updateUI()
    parent.endEditing(true)
  }

  func setWriting() {
    guard
      let writeView = writeView,
      let writeHidingView = writeHidingView
    else { return }

    writeHidingView.isHidden = false
    UIView.animate(withDuration: 0.2) {
      writeView.frame = self.writeFrame
    }
    writeView.updateUIWriting()
  }

  func setExpand() {
    guard
      let view = parent,
      let writeView = writeView,
      let writeHidingView = writeHidingView
    else { return }

    writeHidingView.isHidden = false
    UIView.animate(withDuration: 0.2) {
      writeView.frame = self.detailWriteFrame
    }
    writeView.updateUIToDetail()
    view.endEditing(true)
  }

  func showCalendar() {
    guard
      let view = parent,
      let monthCalendarView = monthCalendarView,
      let monthCalendarHidingView = monthCalendarHidingView
    else { return }

    view.bringSubviewToFront(monthCalendarView)
    view.bringSubviewToFront(monthCalendarHidingView)
//    monthCalendarView.update(date)
    monthCalendarHidingView.isHidden = false
    UIView.animate(withDuration: 0.2) {
      monthCalendarView.frame.origin.y = 0
    }
  }

  func hideCalendar() {
    guard
      let monthCalendarView = monthCalendarView,
      let monthCalendarHidingView = monthCalendarHidingView
    else { return }

    monthCalendarHidingView.isHidden = true
    UIView.animate(withDuration: 0.2) {
      monthCalendarView.frame.origin.y = -Metric.monthCalendarHeight - self.safeAreaInset.top
    }
  }

  private var initFrame: CGRect {
    guard let view = parent else { return .zero }
    return CGRect(
      x: 0,
      y: view.frame.height - Metric.writeViewNormalHeight - safeAreaInset.bottom,
      width: view.frame.width,
      height: Metric.writeViewTotalHeight
    )
  }

  private var normalFrame: CGRect {
    guard let view = parent else { return .zero }
    return CGRect(
      x: 0,
      y: view.frame.height - Metric.writeViewNormalHeight - safeAreaInset.bottom,
      width: view.frame.width,
      height: Metric.writeViewNormalHeight + safeAreaInset.bottom
    )
  }

  private var writeFrame: CGRect {
    guard
      let view = parent,
      let keyboardHeight = keyboardHeight
    else { return normalFrame }

    return CGRect(
      x: 0,
      y: view.frame.height - Metric.writeViewNormalHeight - keyboardHeight,
      width: view.frame.width,
      height: Metric.writeViewNormalHeight
    )
  }

  private var detailWriteFrame: CGRect {
    guard let view = parent else { return .zero }
    return CGRect(
      x: 0,
      y: view.frame.height - Metric.writeViewExpandHeight - safeAreaInset.bottom,
      width: view.frame.width,
      height: Metric.writeViewExpandHeight + safeAreaInset.bottom
    )
  }
}
