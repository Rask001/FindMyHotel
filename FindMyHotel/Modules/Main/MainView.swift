//
//  MainView.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//
import UIKit
fileprivate enum Constants {
	static var popularity = "Popularity"
	static var distance = "Distance from center"
	static var avalibleRooms = "Number of available rooms"
	static var titleBtnColor = UIColor.black
	static var btnBGColor = UIColor.white
}


//MARK: - VIEW
final class MainView: UIViewController {
	
	//MARK: - PROPERTY
	private let tableView = UITableView()
	private let headerView = UIView()
	private let headerStackView = UIStackView()
	private var buttonSortName = [Constants.popularity, Constants.distance, Constants.avalibleRooms]
	private var headerViewTopConstraint: NSLayoutConstraint?
	private var viewModel: MainViewModelProtocol! {
		didSet {
			viewModel.fetchHotelsForMainView {
				self.tableView.reloadData()
			}
		}
	}
	
	//MARK: - LIVECYCLE
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel = MainViewModel()
		setupHeader()
		setupHeaderStackView()
		setupNavigation()
		setupTableView()
		addSubview()
		layout()
	}
	
	//MARK: - SETUP
	private func setupTableView() {
		self.tableView.delegate = self
		self.tableView.dataSource = self
		self.tableView.backgroundColor = .systemGray5
		self.tableView.separatorStyle = .none
		self.tableView.allowsSelection = true
		self.tableView.showsVerticalScrollIndicator = false
		tableView.rowHeight = 300
		self.tableView.register(HotelCell.self, forCellReuseIdentifier: HotelCell.identifire)
	}
	
	private func setupHeader() {
		headerView.backgroundColor = .systemGray5
		headerView.alpha = 0.0
	}
	
	private func setupHeaderStackView() {
		let buttonArray = self.createButtons(input: self.buttonSortName)
		for item in buttonArray {
			self.headerStackView.addArrangedSubview(item)
		}
		self.headerStackView.axis = .vertical
		self.headerStackView.alignment = .center
		self.headerStackView.spacing = 8
		self.headerStackView.distribution = .equalSpacing
		self.headerStackView.backgroundColor = .white
		self.headerStackView.layer.cornerRadius = 10
		self.headerStackView.layer.shadowColor = UIColor.black.cgColor
		self.headerStackView.layer.shadowRadius = 4
		self.headerStackView.layer.shadowOpacity = 0.2
		self.headerStackView.layer.shadowOffset = CGSize(width: 0, height: 3 )
	}
	
	private func createButtons(input: [String]) -> [UIButton] {
		var buttonArray = [UIButton]()
		var buttonTag = 0
		for item in input {
			let button = UIButton()
			button.setTitle(item, for: .normal)
			button.setTitleColor(Constants.titleBtnColor, for: .normal)
			button.translatesAutoresizingMaskIntoConstraints = false
			button.heightAnchor.constraint(equalToConstant: 44).isActive = true
			button.widthAnchor.constraint(equalToConstant: 220).isActive = true
			button.backgroundColor = Constants.btnBGColor
			button.tag = buttonTag
			buttonTag += 1
			button.addTarget(self, action: #selector(tapToSort(sender:)), for: .touchUpInside)
			buttonArray.append(button)
		}
		return buttonArray
	}
	
	private func setupNavigation() {
		let leftButtonItem = UIBarButtonItem(
			title: "⇅ Sort",
			style: .done,
			target: self,
			action: #selector(sortBtnAction)
		)
		self.navigationItem.leftBarButtonItem = leftButtonItem
		self.navigationItem.leftBarButtonItem?.tintColor = .black
	}
	
	@objc func tapToSort(sender: UIButton) {
		self.viewModel.animations.animateHeaderView(headerView: headerView, topConstraint: headerViewTopConstraint!, view: self)
		self.viewModel.sorted(tag: sender.tag)
		self.tableView.reloadData()
	}
	
	@objc func sortBtnAction() {
		self.viewModel.animations.animateHeaderView(headerView: headerView, topConstraint: headerViewTopConstraint!, view: self)
	}
	
	//MARK: - LAYOUT
	private func addSubview() {
		self.view.backgroundColor = .systemGray5
		self.view.addSubview(headerView)
		self.headerView.addSubview(headerStackView)
		self.view.addSubview(tableView)
	}
	
	private func layout() {
		self.tableView.translatesAutoresizingMaskIntoConstraints = false
		self.tableView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor).isActive = true
		self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
		self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		
		self.headerViewTopConstraint = self.headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -160)
		self.headerView.translatesAutoresizingMaskIntoConstraints = false
		self.headerView.heightAnchor.constraint(equalToConstant: 160).isActive = true
		self.headerViewTopConstraint!.isActive = true
		self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
		self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
		
		self.headerStackView.translatesAutoresizingMaskIntoConstraints = false
		self.headerStackView.topAnchor.constraint(equalTo: self.headerView.topAnchor, constant: 7).isActive = true
		self.headerStackView.bottomAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: -7).isActive = true
		self.headerStackView.leadingAnchor.constraint(equalTo: self.headerView.leadingAnchor, constant: 7).isActive = true
		self.headerStackView.trailingAnchor.constraint(equalTo: self.headerView.trailingAnchor, constant: -7).isActive = true
	}
}

//MARK: - EXTENSION UITableViewDataSource
extension MainView: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: HotelCell.identifire, for: indexPath) as! HotelCell
		cell.viewModel = viewModel.cellViewModel(indexPath: indexPath)
		return cell
	}
}

//MARK: - EXTENSION UITableViewDelegate
extension MainView: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.viewModel.hotels.count
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(#function, indexPath.row)
		let hotel = viewModel.hotels[indexPath.row]
		let detailView = ModuleBuilder.createDetailView(hotel: hotel)
		navigationController?.show(detailView, sender: self)
	}
}
