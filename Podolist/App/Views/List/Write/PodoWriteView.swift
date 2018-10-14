//
//  PodoWriteView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

protocol WriteViewDelegate: class {
    func textFieldDidChange(text: String)
    func didChangedPriority(priority: Priority)
    func didChangedDate(date: Date)
    func didTappedDetail()
    func didTappedCreate()
}

class PodoWriteView: BaseView {

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

    override func setup() {
        super.setup()
        titleView.backgroundColor = .white
        titleView.layer.cornerRadius = 15
        titleView.clipsToBounds = true
        addSubview(titleView)
        addSubview(priorityView)
        addSubview(calendarView)
    }

    func updateUI() {
        titleView.frame = CGRect(x: 8, y: 8, width: frame.width - 16, height: 32)
        priorityView.isHidden = true
        calendarView.isHidden = true
    }

    func updateUIToDetail() {
        titleView.frame = CGRect(x: 8, y: 8, width: frame.width - 16, height: 32)
        titleView.titleField.resignFirstResponder()
        priorityView.frame = CGRect(x: 8, y: titleView.frame.maxY + 8, width: frame.width - 16, height: 50)
        priorityView.backgroundColor = .clear
        priorityView.isHidden = false
        calendarView.frame = CGRect(x: 8, y: priorityView.frame.maxY + 8, width: frame.width - 16, height: 200)
        calendarView.backgroundColor = .clear
        calendarView.isHidden = false
    }

    func clear() {
        titleView.clear()
        priorityView.clear()
    }
}
