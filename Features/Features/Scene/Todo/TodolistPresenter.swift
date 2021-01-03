
import UIKit
import Core
import Services

enum WritingMode {
    case create
    case edit
}

enum WritingViewState {
    case `default`
    case expand
    case writing
}

//protocol TodolistPresenterProtocol: class {
//
//    // MARK: - View -> Presenter
//
//    var selectedDate: Date { get }
//
//    func viewDidLoad()
//    func numberOfSections() -> Int
//    func numberOfRows(in section: Int) -> Int
//    func configureSection(_ cell: TodolistSectionCell, forSectionAt section: Int)
//    func configureRow(_ cell: TodolistRowCell, forRowAt indexPath: IndexPath)
//    func didSelect(indexPath: IndexPath)
//    func didTouchedBackground()
//    func didChangedComplete(indexPath: IndexPath, completed: Bool)
//    func didTappedEdit(_ todo: Todo, indexPath: IndexPath)
//    func didTappedDelete(indexPath: IndexPath)
//    func didChangedShowDelayed(show: Bool)
//    func keyboardWillShow()
//
//    // MARK: - Interactor -> Presenter
//
//    func setTodolist(sections: [TodoSection])
//    func createTodoDidFinished(todo: Todo)
//    func updateTodoDidFinished(id: Int, todo: Todo)
//    func deleteTodoDidFinished()
//    func resetTodoOnWriting()
//}

final class TodolistPresenter {

  // MARK: - Properties

  private let todoService: TodoServiceType
  weak var view: TodolistViewProtocol?

  private(set) var selectedDate = Date()
  private var todolist: Todolist?
  private var todo = Todo()
  private var sections: [TodolistSectionModel] = []
  private var writingMode: WritingMode = .create
  private var selectedIndexPath: IndexPath?
  private var viewState: WritingViewState = .default {
    didSet {
      switch viewState {
      case .default:
        view?.showDefaultState()
      case .expand:
        view?.showWritingExpandState()
      case .writing:
        view?.showWritingTitleState()
      }
    }
  }

  init(todoService: TodoServiceType) {
    self.todoService = todoService
  }
}

extension TodolistPresenter {
  func viewDidLoad() {
    fetchTodolist(selectedDate)
    view?.showTodoOnWriting(todo, mode: writingMode)
  }

  func numberOfSections() -> Int {
    sections.count
  }

  func numberOfRows(in section: Int) -> Int {
    sections[section].items.count
  }

  func configureSection(_ cell: TodolistSectionCell, forSectionAt section: Int) {
    let item = sections[section]
    cell.configure(item)
    cell.presenter = self
  }

  func configureRow(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = sections[indexPath.section].items[indexPath.row]
    switch item {
    case .header(TodolistHeaderCellModel):
      <#code#>
    default:
      <#code#>
    }
  }

  func configureRow(_ cell: TodolistRowCell, forRowAt indexPath: IndexPath) {
    let item = sections[indexPath.section].rows[indexPath.row]
    let isSelected = indexPath.section == selectedIndexPath?.section
      && indexPath.row == selectedIndexPath?.row
    cell.configure(item, indexPath: indexPath, isSelected: isSelected)
    cell.selectionStyle = .none
    cell.presenter = self
  }

  func didSelect(indexPath: IndexPath) {
    var indexPathsToReload: [IndexPath] = []
    if let prev = self.selectedIndexPath {
      indexPathsToReload.append(prev)
      if prev == indexPath {
        self.selectedIndexPath = nil
      } else {
        self.selectedIndexPath = indexPath
        indexPathsToReload.append(indexPath)
      }
    } else {
      self.selectedIndexPath = indexPath
      indexPathsToReload.append(indexPath)
    }

    view?.reloadRows(indexPathsToReload, with: .automatic)
  }

  func didTouchedBackground() {
    if writingMode == .edit {
      resetTodoOnWriting()
      view?.showTodoOnWriting(todo, mode: writingMode)
    }
    viewState = .default
    view?.hideMonthCalendar()
  }

  func resetTodoOnWriting() {
    writingMode = .create
    todo = Todo()
    didChangedDate(date: selectedDate)
  }

  func didChangedComplete(indexPath: IndexPath, completed: Bool) {
    let todo = sections[indexPath.section].rows[indexPath.row]
    guard let id = todo.id else { return }
    todo.isCompleted = completed
    interactor.updateTodo(id: id, todo: todo)
  }

  func didTappedEdit(_ todo: Todo, indexPath: IndexPath) {
    analytics.log(.todo_edit)
    self.todo = todo
    writingMode = .edit
    didSelect(indexPath: indexPath)
    view.showTodoOnWriting(todo, mode: writingMode)
    viewState = .expand
  }

  func didTappedDelete(indexPath: IndexPath) {
    guard let id = sections[indexPath.section].rows[indexPath.row].id else { return }
    interactor.deleteTodo(id: id)
    view.reloadRows([indexPath], with: .automatic)
  }

  func didChangedShowDelayed(show: Bool) {
    interactor.updateShowDelayedItems(show: show)
    view.reloadSections([0], with: .automatic)
  }

  func keyboardWillShow() {
    viewState = .writing
  }
}

private extension TodolistPresenter {
  func fetchTodolist(_ date: Date) {
    todoService.getTodos(page: 0, date: date) { [weak self] result in
      guard let `self` = self else { return }
      switch result {
      case .success(let todolist):
        self.todolist = todolist
        let sections = self.updateSections(date: date, todolist: todolist)
        self.presenter?.setTodolist(sections: sections)
      case .failure(let error):
        log.debug(error)
      }
    }
  }

  func fetchTodolist(_ date: Date, reload: Bool = true) {
    if reload == false, let todolist = self.todolist {
      let sections = updateSections(date: date, todolist: todolist)
      self.presenter?.setTodolist(sections: sections)
      return
    }
    todoService.getTodos(page: 0, date: date) { [weak self] result in
      guard let `self` = self else { return }
      switch result {
      case .success(let todolist):
        self.todolist = todolist
        let sections = self.updateSections(date: date, todolist: todolist)
        self.presenter?.setTodolist(sections: sections)
      case .failure(let error):
        log.debug(error)
      }
    }
  }

    func setTodolist(sections: [TodoSection]) {
        self.sections = sections
        view.reloadData()
    }

    func createTodoDidFinished(todo: Todo) {
        analytics.log(.todo_create(todo.title ?? ""))
        selectedDate = todo.startedAt ?? selectedDate
        resetTodoOnWriting()
        viewState = .default
        view.showTodoOnWriting(self.todo, mode: writingMode)
        view.showTopView(selectedDate)
        selectedIndexPath = nil
        interactor.fetchTodolist(selectedDate, reload: true)
    }

    func updateTodoDidFinished(id: Int, todo: Todo) {
        analytics.log(.todo_edit_done)
        resetTodoOnWriting()
        viewState = .default
        view.showTodoOnWriting(self.todo, mode: writingMode)
        selectedIndexPath = nil
        interactor.fetchTodolist(selectedDate, reload: true)
    }

    func deleteTodoDidFinished() {
        analytics.log(.todo_delete)
        selectedIndexPath = nil
        interactor.fetchTodolist(selectedDate, reload: true)
    }
}

// MARK: - MonthCalendarViewDelegate

extension TodolistPresenter: MonthCalendarViewDelegate {

    func calendarView(_ calendarView: MonthCalendarView, didSelectDate date: Date) {
        selectedDate = date
        view.showTopView(date)
        didChangedDate(date: date)
        view.showTodoOnWriting(todo, mode: writingMode)
        interactor.fetchTodolist(selectedDate, reload: true)
    }
}

// MARK: - MainTopViewDelegate

extension TodolistPresenter: MainTopViewDelegate {

    func didTappedSetting() {
        wireFrame.navigate(to: .setting)
    }

    func didTappedMonthCalendar() {
        view.showMonthCalendar(selectedDate)
    }

    func didSelectDate(date: Date) {
        selectedDate = date
        didChangedDate(date: date)
        view.showTodoOnWriting(todo, mode: writingMode)
        interactor.fetchTodolist(selectedDate, reload: true)
    }
}

// MARK: - WriteViewDelegate

extension TodolistPresenter: WriteViewDelegate {

    func textFieldDidChange(text: String) {
        todo.title = text
    }

    func didChangedPriority(priority: Priority) {
        todo.priority = priority
    }

    func didChangedDate(date: Date) {
        todo.startedAt = date
        todo.endedAt = date
        todo.dueAt = date
    }

    func didTappedDetail() {
        if viewState == .default || viewState == .writing {
            viewState = .expand
        } else {
            viewState = .default
        }
    }

    func didTappedCreate() {
        interactor.createTodo(todo: todo)
    }

    func didTappedEdit() {
        guard let id = todo.id else { return }
        interactor.updateTodo(id: id, todo: todo)
    }
}
