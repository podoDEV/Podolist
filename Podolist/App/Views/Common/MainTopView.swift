//
//  MainTopView.swift
//  Podolist
//
//  Copyright © 2018 podo. All rights reserved.
//

class MainTopView: BaseView {

    weak var delegate: TopViewDelegate?

    let backgroundView = UIImageView()
    let titleView = UIView()
    let titleLabel = UILabel()
    let dropdownView = UIImageView()
    let calendarView = PodoCalendarView()
    let gradient = CAGradientLayer()

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var image: UIImage? {
        didSet {
            dropdownView.image = image
        }
    }

    override func setup() {
        super.setup()

        gradient.startPoint = CGPoint(x: 0.5, y: 0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1)
        gradient.colors = [UIColor.gradationStart.cgColor,
                            UIColor.gradationEnd.cgColor]
        gradient.locations = [0, 1]
        backgroundView.layer.addSublayer(gradient)
        addSubview(backgroundView)
        addSubview(calendarView)
        addSubview(titleView)

        titleView.addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = UIFont.appFontB(size: 20)

        titleView.addSubview(dropdownView)
        dropdownView.image = InterfaceImage.dropdown.normalImage
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = self.frame
        backgroundView.frame = self.frame

        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        calendarView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        calendarView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        calendarView.heightAnchor.constraint(equalToConstant: 44).isActive = true

        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        titleView.bottomAnchor.constraint(equalTo: self.calendarView.topAnchor, constant: -4).isActive = true
        titleView.heightAnchor.constraint(equalTo: titleLabel.heightAnchor).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.titleView.topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.titleView.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.titleView.leadingAnchor).isActive = true

        dropdownView.translatesAutoresizingMaskIntoConstraints = false
        dropdownView.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor).isActive = true
        dropdownView.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 10).isActive = true
        dropdownView.trailingAnchor.constraint(equalTo: self.titleView.trailingAnchor).isActive = true
    }
}

protocol TopViewDelegate: class {
    func didHomeAction()
}
