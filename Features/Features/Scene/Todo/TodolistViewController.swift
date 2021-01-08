
import UIKit
import Core
import Services
import Scope
import SnapKit

protocol TodolistViewProtocol: AnyObject {
  func reloadData()
  func showTopView(_ date: Date)
  func showDefaultState()
  func showWritingExpandState()
  func showWritingTitleState()
  func showTodoOnWriting(_ todo: Todo, mode: WritingMode)
  func showMonthCalendar(_ date: Date)
  func hideMonthCalendar()
  func reloadSections(_ indexSet: IndexSet, with animation: UITableView.RowAnimation)
  func deleteRows(_ indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
  func reloadRows(_ indexPaths: [IndexPath], with animation: UITableView.RowAnimation)
}

public final class TodolistViewController: BaseViewController {

  // MARK: - Subviews

  private lazy var compressor: TodolistCompressor = {
    return TodolistCompressor().also {
      $0.parent = view
      $0.monthCalendarView = monthCalendarView
      $0.monthCalendarHidingView = monthCalendarHidingView
      $0.topView = topView
      $0.tableView = tableView
      $0.writeView = writeView
      $0.writeHidingView = writeHidingView
    }
  }()

  private lazy var monthCalendarView: MonthCalendarView = {
    return MonthCalendarView().also {
      $0.delegate = presenter as MonthCalendarViewDelegate
    }
  }()

  private lazy var monthCalendarHidingView: UIView = {
    return UIView().also {
      $0.backgroundColor = .gray
      $0.alpha = 0.5
    }
  }()

  private lazy var topView: MainTopView = {
    return MainTopView().also {
      $0.delegate = presenter as MainTopViewDelegate
    }
  }()

  private lazy var tableView: UITableView = {
    return UITableView(frame: .zero, style: .grouped).also {
      $0.rowHeight = UITableView.automaticDimension
      $0.separatorStyle = .none
      $0.dataSource = self
      $0.delegate = self
      $0.backgroundColor = .white
      $0.sectionFooterHeight = 0
      $0.tableFooterView = UIView()
      $0.register(cell: TodolistHeaderCell.self)
      $0.register(cell: TodolistRowCell.self)
    }
  }()

  private lazy var writeView: TodoWriteView = {
    return TodoWriteView().also {
      $0.delegate = presenter as WriteViewDelegate
      $0.roundCorners([.topLeft, .topRight], radius: 17.25)
      $0.backgroundColor = .backgroundColor1
    }
  }()

  private lazy var writeHidingView: UIView = {
    return UIView().also {
      $0.backgroundColor = .gray
      $0.alpha = 0.5
    }
  }()

  // MARK: - Properties

  let presenter: TodolistPresenter

  init(presenter: TodolistPresenter) {
    self.presenter = presenter
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

//  private var normalFrame: CGRect {
//    return CGRect(
//      x: 0,
//      y: view.frame.height - Metric.writeViewNormalHeight - safeAreaInset.bottom,
//      width: view.frame.width,
//      height: Metric.writeViewNormalHeight + safeAreaInset.bottom
//    )
//  }
//  private var writeFrame: CGRect {
//    if let keyboardHeight = keyboardHeight {
//      return CGRect(
//        x: 0,
//        y: view.frame.height - Metric.writeViewNormalHeight - keyboardHeight,
//        width: view.frame.width,
//        height: Metric.writeViewNormalHeight
//      )
//    }
//    return normalFrame
//  }
//  private var detailWriteFrame: CGRect {
//    return CGRect(
//      x: 0,
//      y: view.frame.height - Metric.writeViewExpandHeight - safeAreaInset.bottom,
//      width: view.frame.width,
//      height: Metric.writeViewExpandHeight + safeAreaInset.bottom
//    )
//  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    analytics.log(.main_view)
    presenter.viewDidLoad()
    compressor.setState(.default)
//    showDefaultState()
  }

  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillAppear(notification:)),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
  }

  public override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setNavigationBarHidden(false, animated: false)
    NotificationCenter.default.removeObserver(
      self,
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
  }

  public override func setupSubviews() {
    [monthCalendarView, monthCalendarHidingView, topView, tableView, writeView, writeHidingView]
      .forEach(view.addSubview)
  }

  public override func setupConstraints() {
    compressor.setState(.initial)
//    monthCalendarHidingView.frame = CGRect(
//      x: 0,
//      y: 0,
//      width: view.bounds.width,
//      height: view.bounds.height + safeAreaInset.bottom
//    )
//    monthCalendarView.frame = CGRect(
//      x: 0,
//      y: -Metric.monthCalendarHeight - safeAreaInset.top,
//      width: view.bounds.width,
//      height: Metric.monthCalendarHeight + safeAreaInset.top
//    )
//    topView.frame.size = CGSize(
//      width: view.bounds.width,
//      height: Metric.topViewHeight + safeAreaInset.top
//    )
//    tableView.frame = CGRect(
//      x: 0,
//      y: topView.frame.maxY,
//      width: view.bounds.width,
//      height: view.bounds.height - topView.frame.height - Metric.writeViewNormalHeight - safeAreaInset.bottom
//    )
//    writeHidingView.frame = CGRect(
//      x: 0,
//      y: 0,
//      width: view.bounds.width,
//      height: view.bounds.height + safeAreaInset.bottom
//    )
//    writeView.frame = normalFrame
  }
}

extension TodolistViewController: TodolistViewProtocol {
  func reloadData() {
    tableView.reloadData()
  }

  func showTopView(_ date: Date) {
    topView.update(date)
  }

  func showDefaultState() {
    compressor.setState(.default)
//    view.bringSubviewToFront(writeView)
//    monthCalendarHidingView.isHidden = true
//    writeHidingView.isHidden = true
//    UIView.animate(withDuration: 0.2) {
//      self.writeView.frame = self.normalFrame
//    }
//    writeView.updateUI()
//    view.endEditing(true)
  }

  func showWritingTitleState() {
    compressor.setState(.writing)
//    writeHidingView.isHidden = false
//    UIView.animate(withDuration: 0.2) {
//      self.writeView.frame = self.writeFrame
//    }
//    writeView.updateUIWriting()
  }

  func showWritingExpandState() {
    compressor.setState(.expand)
//    writeHidingView.isHidden = false
//    UIView.animate(withDuration: 0.2) {
//      self.writeView.frame = self.detailWriteFrame
//    }
//    writeView.updateUIToDetail()
//    view.endEditing(true)
  }

  func showMonthCalendar(_ date: Date) {
    monthCalendarView.update(date)
    compressor.setState(.calendar(show: true))
//    view.bringSubviewToFront(monthCalendarHidingView)
//    view.bringSubviewToFront(monthCalendarView)
//    monthCalendarHidingView.isHidden = false
//    monthCalendarView.update(date)
//    UIView.animate(withDuration: 0.2) {
//      self.monthCalendarView.frame.origin.y = 0
//    }
  }

  func hideMonthCalendar() {
    compressor.setState(.calendar(show: false))
//    monthCalendarHidingView.isHidden = true
//    UIView.animate(withDuration: 0.2) {
//      self.monthCalendarView.frame.origin.y = -Metric.monthCalendarHeight - self.safeAreaInset.top
//    }
  }

  func reloadSections(_ indexSet: IndexSet, with animation: UITableView.RowAnimation) {
    tableView.beginUpdates()
    tableView.reloadSections(indexSet, with: animation)
    tableView.endUpdates()
  }

  func deleteRows(_ indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
    tableView.beginUpdates()
    tableView.deleteRows(at: indexPaths, with: animation)
    tableView.endUpdates()
  }

  func reloadRows(_ indexPaths: [IndexPath], with animation: UITableView.RowAnimation) {
    tableView.beginUpdates()
    tableView.reloadRows(at: indexPaths, with: animation)
    tableView.endUpdates()
  }

  func showTodoOnWriting(_ todo: Todo, mode: WritingMode) {
    writeView.update(todo, mode: mode)
    view.endEditing(true)
  }
}

extension TodolistViewController: UITableViewDataSource, UITableViewDelegate {
  public func numberOfSections(in tableView: UITableView) -> Int {
    presenter.numberOfSections()
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    presenter.numberOfRows(in: section)
  }

  public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let cell = tableView.dequeue(TodolistHeaderCell.self)!
    presenter.configureSection(cell, forSectionAt: section)
    return cell
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeue(TodolistRowCell.self)!
    presenter.configureRow(cell, forRowAt: indexPath)
    return cell
  }

  public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter.didSelect(indexPath: indexPath)
  }
}

extension TodolistViewController {

  @objc func keyboardWillAppear(notification: NSNotification?) {
    guard let keyboardFrame = notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
      return
    }
    compressor.keyboardHeight = keyboardFrame.cgRectValue.height
    presenter.keyboardWillShow()
  }

  public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    presenter.didTouchedBackground()
  }
}