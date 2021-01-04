
import UIKit
import Core
import SnapKit

protocol MainTopViewDelegate: AnyObject {
  func didTappedSetting()
  func didTappedMonthCalendar()
  func didSelectDate(date: Date)
}

final class MainTopView: BaseView {

  // MARK: - Subviews

  private var backgroundView: UIImageView!
  private var settingButton: UIButton!
  private var titleView: UIView!
  private var monthLabel: UILabel!
  private var yearLabel: UILabel!
  private var dropdownView: UIImageView!
  private var calendarView: WeekCalendarView!
  private var gradient: CAGradientLayer!

  weak var delegate: MainTopViewDelegate?

  var date: Date? {
    didSet {
      yearLabel.text = "\(date!.year)"
      monthLabel.text = date?.monthName(.default)
    }
  }

  override func setupSubviews() {
    backgroundView = UIImageView().also {
      addSubview($0)
    }
    settingButton = UIButton().also {
      $0.clipsToBounds = true
      $0.addTarget(self, action: #selector(didTappedSetting), for: .touchUpInside)
      $0.setImage("ic_setting".uiImage, for: .normal)
      addSubview($0)
    }
    titleView = UIView().also {
      let tap = UITapGestureRecognizer(
        target: self,
        action: #selector(didTappedMonthCalendar)
      )
      $0.addGestureRecognizer(tap)
      addSubview($0)
    }
    monthLabel = UILabel().also {
      $0.font = .preferredFont(type: .notoSansMedium, size: 20)
      $0.textColor = .white
      titleView.addSubview($0)
    }
    yearLabel = UILabel().also {
      $0.font = .preferredFont(type: .notoSansMedium, size: 20)
      $0.textColor = .white
      titleView.addSubview($0)
    }
    dropdownView = UIImageView().also {
      $0.image = "ic_dropdown".uiImage
      titleView.addSubview($0)
    }
    calendarView = WeekCalendarView().also {
      $0.delegate = self
      addSubview($0)
    }
    gradient = CAGradientLayer().also {
      $0.startPoint = CGPoint(x: 0.5, y: 0)
      $0.endPoint = CGPoint(x: 0.5, y: 1)
      $0.colors = [
        UIColor.gradationStart.cgColor,
        UIColor.gradationEnd.cgColor
      ]
      $0.locations = [0, 1]
      backgroundView.layer.addSublayer($0)
    }
    date = calendarView.date
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    gradient.frame = self.frame
    backgroundView.frame = self.frame

    settingButton.translatesAutoresizingMaskIntoConstraints = false
    settingButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
    settingButton.bottomAnchor.constraint(equalTo: self.calendarView.topAnchor, constant: -16).isActive = true
    settingButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    settingButton.widthAnchor.constraint(equalTo: settingButton.heightAnchor).isActive = true

    titleView.translatesAutoresizingMaskIntoConstraints = false
    titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
    titleView.bottomAnchor.constraint(equalTo: self.calendarView.topAnchor, constant: -16).isActive = true
    titleView.heightAnchor.constraint(equalTo: monthLabel.heightAnchor).isActive = true

    monthLabel.translatesAutoresizingMaskIntoConstraints = false
    monthLabel.topAnchor.constraint(equalTo: self.titleView.topAnchor).isActive = true
    monthLabel.bottomAnchor.constraint(equalTo: self.titleView.bottomAnchor).isActive = true
    monthLabel.leadingAnchor.constraint(equalTo: self.titleView.leadingAnchor).isActive = true

    yearLabel.translatesAutoresizingMaskIntoConstraints = false
    yearLabel.bottomAnchor.constraint(equalTo: self.titleView.bottomAnchor).isActive = true
    yearLabel.leadingAnchor.constraint(equalTo: self.monthLabel.trailingAnchor, constant: 10).isActive = true

    dropdownView.translatesAutoresizingMaskIntoConstraints = false
    dropdownView.centerYAnchor.constraint(equalTo: self.yearLabel.centerYAnchor).isActive = true
    dropdownView.leadingAnchor.constraint(equalTo: self.yearLabel.trailingAnchor, constant: 10).isActive = true
    dropdownView.trailingAnchor.constraint(equalTo: self.titleView.trailingAnchor).isActive = true

    calendarView.translatesAutoresizingMaskIntoConstraints = false
    calendarView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    calendarView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    calendarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    calendarView.heightAnchor.constraint(equalToConstant: 60).isActive = true
  }

  func update(_ date: Date) {
    self.date = date
    calendarView.update(date)
  }

  @objc func didTappedSetting() {
    delegate?.didTappedSetting()
  }

  @objc func didTappedMonthCalendar() {
    analytics.log(.calendar_view)
    delegate?.didTappedMonthCalendar()
  }
}

extension MainTopView: WeekCalendarViewDelegate {

  func calendarView(_ calendarView: WeekCalendarView, didSelectDate date: Date) {
    self.date = date
    delegate?.didSelectDate(date: date)
  }
}
