//
//  PodoWriteView.swift
//  Podolist
//
//  Copyright © 2018년 podo. All rights reserved.
//

import UIKit

class PodoWriteView: BaseView {

    private let titleView = PodoWriteTitleView().loadNib() as! PodoWriteTitleView
    private let priorityView = PodoWritePriorityView().loadNib() as! PodoWritePriorityView
    private let calendarView = PodoWriteCalendarView().loadNib() as! PodoWriteCalendarView

    weak var delegate: WriteViewDelegate? {
        didSet {
            titleView.delegate = delegate
        }
    }

    var mode: Mode?

    override func setup() {
        super.setup()
        titleView.backgroundColor = .white
        titleView.layer.cornerRadius = 15
        titleView.clipsToBounds = true
        addSubview(titleView)
        addSubview(priorityView)
        addSubview(calendarView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateUI(mode: mode)
    }

    func updateUI(mode: Mode?) {
        guard let mode = mode else {
            return
        }

        switch mode {
        case .normal:
            titleView.frame = CGRect(x: 12, y: 8, width: frame.width - 24, height: 32)
            priorityView.isHidden = true
            calendarView.isHidden = true
        case .detail:
            titleView.frame = CGRect(x: 12, y: 8, width: frame.width - 24, height: 32)
            priorityView.frame = CGRect(x: 12, y: titleView.frame.maxY + 8, width: frame.width - 24, height: 50)
            priorityView.backgroundColor = .clear
            priorityView.isHidden = false
            calendarView.frame = CGRect(x: 12, y: priorityView.frame.maxY + 8, width: frame.width - 24, height: 200)
            calendarView.backgroundColor = .clear
            calendarView.isHidden = false

        default:
            break
        }
//        switch mode {
//        case .normal:
//            break
//        case .detail:
//            break
//            frame: CGRect(x: roundView.frame.origin.x, y: self.frame.origin.y + roundView.frame.height, width: roundView.frame.width, height: Style.Write.Priority.height)
//            let priorityView = PodoWritePriorityView()
//            addSubview(priorityView)
//            addSubview(calendarView)
//            self.view.addSubview(priorityView)
//            priorityView = PodoWritePriorityView().loadNib() as? PodoWritePriorityView
//            priorityView!.frame = CGRect(x: roundView.frame.origin.x, y: roundView.frame.origin.y + roundView.frame.height, width: roundView.frame.width, height: Style.Write.Priority.height)
//            calendarView = PodoWriteCalendarView().loadNib() as? PodoWriteCalendarView
//            calendarView!.frame = CGRect(x: priorityView!.frame.origin.x, y: priorityView!.frame.origin.y + priorityView!.frame.height, width: roundView.frame.width, height: Style.Write.Calendar.height)
//            addSubview(priorityView!)
//            addSubview(calendarView!)
//            self.backgroundColor = .grayE
//            break
//        }
    }
//
//    @IBAction func pressOption() {
//        if let delegate = delegate {
//            delegate.pressOption()
//        }
//    }
}

protocol WriteViewDelegate: class {
    func didTappedDetail()
    func didTappedSend()
}
