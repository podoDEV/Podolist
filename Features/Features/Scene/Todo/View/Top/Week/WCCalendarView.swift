
import UIKit
import Core
import SwiftDate

protocol WCCalendarViewDelegate: NSObjectProtocol {
  func calendarView(didSelectDate date: DateInRegion)
}

class WCCalendarView: UIScrollView {

  weak var calDelegate: WCCalendarViewDelegate?

  var weeks = [WCWeekView]()
  var currentPosition = 1
  var selectedDate: DateInRegion?

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  func setup() {
    isPagingEnabled = true
    showsVerticalScrollIndicator = false
    showsHorizontalScrollIndicator = false

    var date = DateInRegion().dateAt(.prevWeek)
    for _ in 0..<3 {
      let week = WCWeekView()
      week.date = date
      addSubview(week)
      weeks.append(week)
      date = date.dateAt(.nextWeek)
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    var x: CGFloat = 0
    for week in weeks {
      week.frame = CGRect(x: x, y: 0, width: bounds.size.width, height: bounds.size.height)
      x = week.frame.maxX
    }
    contentSize = CGSize(width: bounds.size.width * CGFloat(weeks.count), height: bounds.size.height)
  }
}

extension WCCalendarView {

  func update(_ dateInRegion: DateInRegion) {
    var date = dateInRegion.dateAt(.prevWeek)
    for week in weeks {
      week.date = date
      date = date.dateAt(.nextWeek)
    }
    selectDate(date: dateInRegion)
  }

  func move(to toDirection: Direction) {
    let page1 = weeks[0]
    let page2 = weeks[1]
    let page3 = weeks[2]

    let prevX = page1.frame.origin.x
    let currentX = page2.frame.origin.x
    let nextX = page3.frame.origin.x

    if toDirection == .prev {
      page1.frame.origin.x = currentX
      page2.frame.origin.x = nextX
      page3.frame.origin.x = prevX
      page3.date = page1.date?.dateAt(.prevWeek)
      weeks = [page3, page1, page2]
      contentOffset.x = frame.width
      let date = selectedDate!.dateByAdding(-7, .day)
      selectDate(date: date)
      calDelegate?.calendarView(didSelectDate: date)
    }

    if toDirection == .next {
      page1.frame.origin.x = nextX
      page2.frame.origin.x = prevX
      page3.frame.origin.x = currentX
      page1.date = page3.date?.dateAt(.nextWeek)
      weeks = [page2, page3, page1]
      contentOffset.x = frame.width
      let date = selectedDate!.dateByAdding(7, .day)
      selectDate(date: date)
      calDelegate?.calendarView(didSelectDate: date)
    }
  }

  private func selectDate(date: DateInRegion) {
    selectedDate = date
    let selectedDateComps = CalendarUtil.dateComponentsOfDate(date: date.date)
    for week in weeks {
      for day in week.days {
        if let date = day.date,
           date.year == selectedDateComps.year,
           date.month == selectedDateComps.month,
           date.day == selectedDateComps.day {
          day.isSelected = true
        } else {
          day.isSelected = false
        }
      }
    }
  }

  internal enum Direction: Int {
    case prev = 0
    case next = 2
  }
}
