//
//  CalendarViewController.swift
//  Eventery
//
//  Created by Andrew Chiu on 4/28/23.
//

import UIKit

// cornell color
let carnelliam = UIColor(red: 179 / 255.0, green: 27 / 255.0, blue: 27 / 255.0, alpha: 1.0)

class CalendarViewController: UIViewController {
    // Outlet collection of labels
    @IBOutlet var headerLabels: [UILabel]!
    @IBOutlet var subheaderLabels: [UILabel]!
    @IBOutlet var textLabels: [UILabel]!

    // text scalars
    let headerRelativeFontConstant: CGFloat = 0.046
    let subheaderRelativeFontConstant: CGFloat = 0.046 * (2 / 3)
    let textRelativeFontConstant: CGFloat = 0.046 * (1 / 2)

    // distance of arrows from edges
    let arrowOffset = 30.0

    // padding distance
    let padding = 10.0
    let calPadding = 2.0
    let itemPadding: CGFloat = 2.0
    let sectionPadding: CGFloat = 2.0
    let belowCalPadding = 100.0

    // height of weekday stackview
    let weekdayHeight = 50.0

    // height of rows in the event tableview
    let eventRowHeight = 50.0

    // reuse IDs
    let cellReuseID = "cellReuseID"
    let headerReuseID = "headerReuseID"
    let filterReuseID = "filerReuseID"
    let tableReuseID = "tableReuseID"
    let collectionViewTag = 0
    let filterViewTag = 1

    // UI elements
    var monthLabel = UILabel()

    let buttonConfig = UIImage.SymbolConfiguration(scale: .medium)
    let leftButtonImage = UIImage(systemName: "arrowshape.turn.up.left.circle.fill")
    var leftButton = UIButton()

    let rightButtonImage = UIImage(systemName: "arrowshape.turn.up.right.circle.fill")
    var rightButton = UIButton()

    var weekdayStackView = UIStackView()

    var calendarCollectionView: UICollectionView!

    let eventCalendarTableView = UITableView()

    // Day of the week labels
    let mon = UILabel()

    let tue = UILabel()

    let wed = UILabel()

    let thu = UILabel()

    let fri = UILabel()

    let sat = UILabel()

    let sun = UILabel()

    // model stuff
    var selectedDate = Date()
    var userSelectedDate = Date()
    var totalSquares = [CalendarDay]()
    var events: [Event] = []
    var userSelectedEvents: [Event] = []

    init(events: [Event]) {
        self.events = events
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        headerLabels = []
        subheaderLabels = []
        textLabels = []

        // query all of the events for today
        // TODO: this

        // add headerlabels
        headerLabels.append(monthLabel)

        // add subheaderlabels
        // (none) but will be the events in the table

        // add text labels
        textLabels.append(mon)
        textLabels.append(tue)
        textLabels.append(wed)
        textLabels.append(thu)
        textLabels.append(fri)
        textLabels.append(sat)
        textLabels.append(sun)
        // the times of the events will be text

        // apply a font size to all the header labels.
        if let heady = headerLabels {
            for label in heady {
                label.font = label.font.withSize(view.frame.height * headerRelativeFontConstant)
                label.textColor = UIColor.label
            }
        }

        // apply a font size to all the subheader labels.
        if let subby = subheaderLabels {
            for label in subby {
                label.font = label.font.withSize(view.frame.height * subheaderRelativeFontConstant)
                label.textColor = UIColor.secondaryLabel
            }
        }

        // apply a font size to all the text labels.
        if let texty = textLabels {
            for label in texty {
                label.font = label.font.withSize(view.frame.height * textRelativeFontConstant)
                label.textColor = UIColor.secondaryLabel
            }
        }

        // setup the button actions and tint
        leftButton.tintColor = carnelliam
        leftButton.addTarget(self, action: #selector(previousMonth), for: .touchUpInside)

        rightButton.tintColor = carnelliam
        rightButton.addTarget(self, action: #selector(nextMonth), for: .touchUpInside)

        // setup the days of the week labels
        mon.text = "Mon"
        mon.textAlignment = .center
        tue.text = "Tue"
        tue.textAlignment = .center
        wed.text = "Wed"
        wed.textAlignment = .center
        thu.text = "Thu"
        thu.textAlignment = .center
        fri.text = "Fri"
        fri.textAlignment = .center
        sat.text = "Sat"
        sat.textAlignment = .center
        sun.text = "Sun"
        sun.textAlignment = .center

        // setup the days of the week stack view
        weekdayStackView.axis = .horizontal
        weekdayStackView.distribution = .fillEqually
        weekdayStackView.alignment = .fill
        weekdayStackView.addArrangedSubview(mon)
        weekdayStackView.addArrangedSubview(tue)
        weekdayStackView.addArrangedSubview(wed)
        weekdayStackView.addArrangedSubview(thu)
        weekdayStackView.addArrangedSubview(fri)
        weekdayStackView.addArrangedSubview(sat)
        weekdayStackView.addArrangedSubview(sun)

        // set up the calendar collection view and flow layout
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = itemPadding
        flowLayout.minimumLineSpacing = itemPadding
        flowLayout.sectionInset = UIEdgeInsets(top: sectionPadding, left: sectionPadding, bottom: sectionPadding, right: sectionPadding)

        calendarCollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        calendarCollectionView.register(CalendarCell.self, forCellWithReuseIdentifier: cellReuseID)
        calendarCollectionView.dataSource = self
        calendarCollectionView.delegate = self
        calendarCollectionView.tag = collectionViewTag

        // set up the tableview for the events
        eventCalendarTableView.delegate = self
        eventCalendarTableView.dataSource = self
        eventCalendarTableView.register(EventCalendarTableViewCell.self, forCellReuseIdentifier: tableReuseID)
        eventCalendarTableView.rowHeight = eventRowHeight
        eventCalendarTableView.backgroundColor = .blue

        // add to view
        view.addSubview(monthLabel)
        view.addSubview(leftButton)
        view.addSubview(rightButton)
        view.addSubview(weekdayStackView)
        view.addSubview(calendarCollectionView)
        view.addSubview(eventCalendarTableView)

        // turn off constraints
        monthLabel.translatesAutoresizingMaskIntoConstraints = false
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        weekdayStackView.translatesAutoresizingMaskIntoConstraints = false
        calendarCollectionView.translatesAutoresizingMaskIntoConstraints = false
        eventCalendarTableView.translatesAutoresizingMaskIntoConstraints = false

        // setup the label and fill in the collection view
        setMonthView()

        // setup constraints
        setupConstrains()

        // add button images
        leftButton.addImage(image: leftButtonImage!, offset: 0.0)
        rightButton.addImage(image: rightButtonImage!, offset: 0.0)
    }

    func setMonthView() {
        totalSquares.removeAll()

        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: selectedDate)

        let prevMonth = CalendarHelper().minusMonth(date: selectedDate)
        let daysInPrevMonth = CalendarHelper().daysInMonth(date: prevMonth)

        var count = 1

        while count <= 42 {
            let calendarDay = CalendarDay()
            if count <= startingSpaces {
                let prevMonthDay = daysInPrevMonth - startingSpaces + count
                calendarDay.day = String(prevMonthDay)
                calendarDay.month = CalendarDay.Month.previous
            } else if count - startingSpaces > daysInMonth {
                calendarDay.day = String(count - daysInMonth - startingSpaces)
                calendarDay.month = CalendarDay.Month.next
            } else {
                calendarDay.day = String(count - startingSpaces)
                calendarDay.month = CalendarDay.Month.current
            }
            calendarDay.date = CalendarHelper().dayFrom(date: CalendarHelper().firstOfMonth(date: selectedDate), offset: count - startingSpaces - 1)

            totalSquares.append(calendarDay)
            count += 1
        }

        monthLabel.text = CalendarHelper().monthString(date: selectedDate) + " " + CalendarHelper().yearString(date: selectedDate)
        calendarCollectionView.reloadData()
        monthLabel.textAlignment = .center

        eventCalendarTableView.reloadData()
    }

    func setupConstrains() {
        NSLayoutConstraint.activate([
            monthLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            monthLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])

        NSLayoutConstraint.activate([
            leftButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
            leftButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: arrowOffset),
        ])

        NSLayoutConstraint.activate([
            rightButton.centerYAnchor.constraint(equalTo: monthLabel.centerYAnchor),
            rightButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -1 * arrowOffset),
        ])

        NSLayoutConstraint.activate([
            weekdayStackView.topAnchor.constraint(equalTo: monthLabel.bottomAnchor, constant: padding),
            weekdayStackView.heightAnchor.constraint(equalToConstant: weekdayHeight),
            weekdayStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            weekdayStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
        ])

        NSLayoutConstraint.activate([
            calendarCollectionView.topAnchor.constraint(equalTo: weekdayStackView.bottomAnchor, constant: padding),
            calendarCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            calendarCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor), calendarCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: belowCalPadding),
        ])

        NSLayoutConstraint.activate([
            eventCalendarTableView.topAnchor.constraint(equalTo: calendarCollectionView.bottomAnchor, constant: padding),
            eventCalendarTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
            eventCalendarTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding),
            eventCalendarTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
        ])
    }

    // adding to events
    func eventsForUserDay() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let userSelectedDateString = dateFormatter.string(from: userSelectedDate)
        NetworkManager.shared.getAllEventsByDay(date: userSelectedDateString) {
            events in
            DispatchQueue.main.async {
                self.userSelectedEvents = events
            }
        }
        print(userSelectedDateString)
        print(userSelectedEvents.count)
    }

    // button actions
    @objc func previousMonth(sender: UIButton!) {
        selectedDate = CalendarHelper().minusMonth(date: selectedDate)
        setMonthView()
    }

    @objc func nextMonth(sender: UIButton!) {
        selectedDate = CalendarHelper().plusMonth(date: selectedDate)
        setMonthView()
    }

    // don't turn the calendar!
    override open var shouldAutorotate: Bool {
        return false
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        eventCalendarTableView.reloadData()
    }
}

extension CalendarViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = calendarCollectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as! CalendarCell

        let calendarDay = totalSquares[indexPath.item]
        cell.dayOfTheMonth.text = calendarDay.day
        if calendarDay.month == CalendarDay.Month.current {
            cell.dayOfTheMonth.textColor = .black
        } else {
            cell.dayOfTheMonth.textColor = .lightGray
        }

        let calendarDayDate = totalSquares[indexPath.item].date
        if calendarDayDate == userSelectedDate {
            cell.backgroundColor = carnelliam
        } else {
            cell.backgroundColor = .systemBackground
        }

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        userSelectedDate = totalSquares[indexPath.item].date
        calendarCollectionView.reloadData()
        eventsForUserDay()
        eventCalendarTableView.reloadData()
    }
}

extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
}

extension CalendarViewController: UITableViewDelegate {}

extension CalendarViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userSelectedEvents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventCalendarTableView.dequeueReusableCell(withIdentifier: tableReuseID) as! EventCalendarTableViewCell
        let event = userSelectedEvents[indexPath.row]

        cell.updateFrom(title: event.title, date: event.start)
        return cell
    }
}

extension UIButton {
    func addImage(image: UIImage, offset: CGFloat) {
        setImage(image, for: .normal)
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
