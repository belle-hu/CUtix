//
//  TicketViewController.swift
//  CUTixApp
//
//  Created by Maisie Yan on 11/18/23.
//

import Foundation
import UIKit
import SnapKit

class EventViewController: UIViewController {
    
    // MARK: - Properties (view)
    
    private var collectionViewOne: UICollectionView!
    private var filterCollectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    private let eventTitle = UILabel()
    private var sortByTimeButton = UIButton()
    private let datePicker = UIDatePicker()
    private let datePickerButton = UIButton()
    
    private let searchButton = UIButton()
    private let moneyButton = UIButton()
    private let profileButton = UIButton()
    
    // MARK: - Properties (data)
    let filters: [String] = ["All", "Concerts", "Clubs", "Sports", "Festivals", "Workshops"]
    
    var dummyData: [Event] = [Event(id: 1234, name: "Hockey: Cornell v Harvard", time: Date(timeIntervalSince1970: 1679775600), category: "Sports", location: "Ithaca", price: 20.00, eventImageUrl: "https://content.etilize.com/Finish/1031247865.jpg"), Event(id: 5542, name: "mxmtoon concert", time: Date(timeIntervalSince1970: 1679901600), category: "Concerts", location: "Ithaca", price: 10.00, eventImageUrl: "https://content.etilize.com/Finish/1031247865.jpg"), Event(id: 9876, name: "Tennis: Cornell vs Columbia", time: Date(timeIntervalSince1970: 1708399200), category: "Sports", location: "Ithaca", price: 8.00, eventImageUrl: "https://content.etilize.com/Finish/1031247865.jpg"), Event(id: 332, name: "Club event", time: Date(timeIntervalSince1970: 1718399300), category: "Clubs", location: "Duffield", price: 5.00, eventImageUrl: "https://content.etilize.com/Finish/1031247865.jpg")
    ]
    
    var allEvents: [Event] = []
    var filtered: [Event] = []
    var filterEvents: String? = nil
    // var user: User
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        title = "CUTix"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        filtered = dummyData
        allEvents = dummyData
        
        setupHorizCollectionView()
        setupEventTitle()
        setupTimeSortButton()
        setupCollectionView()
        setupDatePickerButton()
        
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValue(_:)), for: .valueChanged)
        
        setupDatePickerButton()
        setupButtons()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented" )
    }
    
    func setupEventTitle() {
        eventTitle.text = "Events"
        eventTitle.textColor = .black
        eventTitle.font = UIFont(name: "SF Pro", size: 32)
        eventTitle.font = .systemFont(ofSize: 32, weight: .semibold)
        
        view.addSubview(eventTitle)
        
        eventTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(14)
            make.top.equalTo(filterCollectionView.snp.bottom).offset(20)
        }
        
    }
    
    func setupTimeSortButton() {
        sortByTimeButton.addTarget(self, action: #selector(sortTickets), for: .touchUpInside)
        sortByTimeButton.setTitle("Sort by:", for: .normal)
        sortByTimeButton.setTitleColor(.black, for: .normal)
        sortByTimeButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
       
        sortByTimeButton.layer.borderColor = UIColor.black.cgColor
        sortByTimeButton.layer.borderWidth = 1.0

        view.addSubview(sortByTimeButton)

        sortByTimeButton.snp.makeConstraints { make in
            make.top.equalTo(filterCollectionView.snp.bottom).offset(9)
            make.trailing.equalToSuperview().offset(-25)
            make.width.equalTo(87)
        }
    }
    
    @objc private func sortTickets() {
        let alertController = UIAlertController(title: "Sort by:", message: nil, preferredStyle: .actionSheet)
        let sortByDateAction = UIAlertAction(title: "Date", style: .default) { [weak self] _ in
            self?.sortDate()
        }
        let sortByPriceAction = UIAlertAction(title: "Price", style: .default) { [weak self] _ in
            self?.sortPrice()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(sortByDateAction)
        alertController.addAction(sortByPriceAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func sortDate() {
        filtered.sort { $0.time < $1.time }
        collectionViewOne.reloadData()
    }
    
    @objc private func sortPrice() {
        filtered.sort { $0.price < $1.price }
        collectionViewOne.reloadData()
    }
    
    private func setupHorizCollectionView() {
        let horizlayout = UICollectionViewFlowLayout()
        horizlayout.scrollDirection = .horizontal
        
        filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: horizlayout)
        filterCollectionView.register(FilterCollectionView.self, forCellWithReuseIdentifier: FilterCollectionView.reuse)
        filterCollectionView.delegate = self
        filterCollectionView.dataSource = self
        filterCollectionView.showsHorizontalScrollIndicator = false
        filterCollectionView.alwaysBounceHorizontal = true
        
        view.addSubview(filterCollectionView)
        
        filterCollectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(90)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().inset(15)
            make.height.equalTo(32)
            make.width.equalTo(116)
        }
    }
    
    private func setupCollectionView() {
        // Create a FlowLayout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 35
        layout.minimumInteritemSpacing = 16
        
        // Initialize CollectionView with the layout
        collectionViewOne = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewOne.register(EventCollectionView.self, forCellWithReuseIdentifier: EventCollectionView.reuse)
        collectionViewOne.delegate = self
        collectionViewOne.dataSource = self
        collectionViewOne.alwaysBounceVertical = true

        view.addSubview(collectionViewOne)
        
        collectionViewOne.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(filterCollectionView.snp.bottom).offset(60)
            make.bottom.equalToSuperview().offset(-50)
        }
        
    }
    
    func setupDatePickerButton() {
        datePickerButton.addTarget(self, action: #selector(pickDateButtonTapped), for: .touchUpInside)
        datePickerButton.setTitle("   Select a Date:", for: .normal)
        datePickerButton.setTitleColor(.black, for: .normal)
        datePickerButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        datePickerButton.layer.borderColor = UIColor.black.cgColor
        datePickerButton.layer.borderWidth = 1.0
        datePickerButton.contentHorizontalAlignment = .left
        
        view.addSubview(datePickerButton)
        
        datePickerButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(150)
            make.width.equalTo(345)
        }
    }
    
    func showDatePicker() {
        let alertController = UIAlertController(title: "\n", message: nil, preferredStyle: .actionSheet)
        
        alertController.view.addSubview(datePicker)
        
        datePicker.snp.makeConstraints { make in
            make.centerX.equalTo(alertController.view)
            make.top.equalTo(alertController.view).offset(5)
        }
        
        let doneAction = UIAlertAction(title: "Done", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let selectedDate = self.datePicker.date
            self.filterEventsByDate(selectedDate)
        }
        alertController.addAction(doneAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func filterEventsByDate(_ selectedDate: Date) {
        filtered = dummyData.filter { Calendar.current.isDate($0.time, inSameDayAs: selectedDate) }
        collectionViewOne.reloadData()
    }
    
    @objc func datePickerValue(_ sender: UIDatePicker) {
        let selectedDate = sender.date
    }
    
    @IBAction func pickDateButtonTapped(_ sender: UIButton) {
        showDatePicker()
    }
    
    @objc private func moneyButtonTapped() {
        let sellViewController = SellViewController()
        navigationController?.pushViewController(sellViewController, animated: true)
    }
    
    @objc private func profileButtonTapped() {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    private func setupButtons() {
        searchButton.setImage(UIImage(named: "Search icon"), for: .normal)
        profileButton.setImage(UIImage(named: "pfp"), for: .normal)
        moneyButton.setImage(UIImage(named: "ph_money-thin"), for: .normal)
        
        moneyButton.addTarget(self, action: #selector(moneyButtonTapped), for: .touchUpInside)
        profileButton.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
  
        view.addSubview(searchButton)
        view.addSubview(profileButton)
        view.addSubview(moneyButton)
        
        searchButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-13)
            make.leading.equalToSuperview().offset(72)
        }
        
        moneyButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-7)
            make.centerX.equalToSuperview()
            make.width.equalTo(41)
            make.height.equalTo(38)
        }

        profileButton.snp.makeConstraints { make in
            make.bottom.equalTo(moneyButton.snp.bottom).offset(-5)
            make.trailing.equalToSuperview().offset(-72)
            make.size.equalTo(30)
        }
    }
    
}

// MARK: - UICollectionView DataSource
extension EventViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewOne {
            return filtered.count
        }
        else if collectionView == filterCollectionView {
            return filters.count
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewOne{
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EventCollectionView.reuse, for: indexPath) as? EventCollectionView else { return UICollectionViewCell() }
            cell.configure(dummyData: filtered[indexPath.row])
            return cell
        }
        else if collectionView == filterCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionView.reuse, for: indexPath) as? FilterCollectionView else { return UICollectionViewCell() }
            let filter = filters[indexPath.item]
            let selected = filter == filterEvents
            cell.configure(filter: filter, isSelected: selected)
            return cell
        }
        return UICollectionViewCell()
    }

}

// MARK: - UICollectionViewDelegateFlowLayout

extension EventViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewOne {
            let width = collectionView.frame.width - 16
            let height : CGFloat = 126
            return CGSize(width: width, height: height)
        }
        else if collectionView == filterCollectionView {
            let width : CGFloat = 116
            let height : CGFloat = 32
            return CGSize(width: width, height: height)
        }
        return CGSize(width: 100, height: 100)
    }
}

extension EventViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == collectionViewOne {
            let selected = filtered[indexPath.row]
            let detailedVC = DetailedVC(event: filtered[indexPath.row])
            navigationController?.pushViewController(detailedVC, animated: true)
        }
        else if collectionView == filterCollectionView {
            filterEvents = filters[indexPath.item]
            if filterEvents == "All" {
                filtered = allEvents
            } else {
                if let categories = filterEvents {
                    filtered = dummyData.filter { $0.category == categories }
                }
            }
        }
        collectionViewOne.reloadData()
        filterCollectionView.reloadData()
    }
    
}
