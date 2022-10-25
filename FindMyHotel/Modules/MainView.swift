//
//  MainView.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//
import UIKit

//MARK: - VIEW
class MainView: UIViewController {
	
	//MARK: - PROPERTY
	private let tableView = UITableView()
	private var viewModel: MainViewModelProtocol! {
		didSet {
			viewModel.fetchHotels {
				self.tableView.reloadData()
			}
		}
	}
	
	//MARK: - LIVECYCLE
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel = MainViewModel()
		setupTableView()
		addSubview()
		layout()
	}
	
	//MARK: - SETUP
	private func setupTableView() {
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = .secondarySystemBackground
		self.tableView.separatorStyle = .none
		self.tableView.allowsSelection = false
		self.tableView.showsVerticalScrollIndicator = false
		tableView.rowHeight = 300
		self.tableView.register(HotelCell.self, forCellReuseIdentifier: HotelCell.identifire)
	}
	
	
	//MARK: - LAYOUT
	private func addSubview() {
		self.view.addSubview(tableView)
	}
	
	private func layout() {
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
		self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
		self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
		self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
	}
}

//MARK: - EXTENSION
extension MainView: UITableViewDelegate, UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.viewModel.hotels.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: HotelCell.identifire, for: indexPath) as! HotelCell
		cell.viewModel = viewModel.cellViewModel(indexPath: indexPath)
		return cell
	}
}
