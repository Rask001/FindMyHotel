//
//  MainView.swift
//  FindMyHotel
//
//  Created by Антон on 25.10.2022.
//
import UIKit


final class MainView: UIViewController {
	
	//MARK: - Constants
	private enum Constants {
		static let popularity = "Popularity"
		static let distance = "Distance from center"
		static let avalibleRooms = "Number of available rooms"
		static let sortNavButton = "⇅ Sort"
		static let titleBtnColor = UIColor.black
		static let btnBGColor = UIColor.white
	}
	
	//MARK: - SizeConstants
	private enum Size {
		static let rowHeight: CGFloat = 300
		static let headerViewHeight: CGFloat = 130
		static let headerStaackViewCornerRadius: CGFloat = 10
		static let headerStaackViewShadowRadius: CGFloat = 4
		static let headerStaackViewShadowOpacity: Float = 0.2
		static let headerStaackViewShadowOffset: CGSize = CGSize(width: 0, height: 3 )
	}
	
	//MARK: - PROPERTY
	private let tableView = UITableView()
	private let headerView = UIView()
	private let headerStackView = UIStackView()
	private let buttonSortName = [Constants.popularity, Constants.distance, Constants.avalibleRooms]
	private var headerViewTopConstraint: NSLayoutConstraint?
	private var viewModel: MainViewModelProtocol! {
		didSet {
			viewModel.fetchHotelsForMainView { [weak self] in
				guard let self = self else { return }
				DispatchQueue.main.async {
					self.tableView.reloadData()
				}
			}
		}
	}
	
	//MARK: - LIVECYCLE
	override func viewDidLoad() {
		setupNotification()
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
		tableView.delegate = self
		tableView.dataSource = self
		tableView.backgroundColor = .systemGray5
		tableView.separatorStyle = .none
		tableView.allowsSelection = true
		tableView.allowsMultipleSelection = false
		tableView.showsVerticalScrollIndicator = false
		tableView.rowHeight = Size.rowHeight
		tableView.register(HotelCell.self, forCellReuseIdentifier: HotelCell.identifire)
	}
	
	private func setupNotification() {
		NotificationCenter.default.addObserver(self, selector: #selector(allertUI), name: Notification.Name("errorSend"), object: .none)
	}
	
	private func setupHeader() {
		headerView.backgroundColor = .systemGray5
		headerView.alpha = 0.0
	}
	
	private func setupHeaderStackView() {
		let buttonArray = createButtons(input: buttonSortName)
		for item in buttonArray {
			headerStackView.addArrangedSubview(item)
		}
		headerStackView.axis = .vertical
		headerStackView.alignment = .center
		headerStackView.distribution = .equalSpacing
		headerStackView.backgroundColor = .white
		headerStackView.layer.cornerRadius = Size.headerStaackViewCornerRadius
		headerStackView.layer.shadowColor = UIColor.black.cgColor
		headerStackView.layer.shadowRadius = Size.headerStaackViewShadowRadius
		headerStackView.layer.shadowOpacity = Size.headerStaackViewShadowOpacity
		headerStackView.layer.shadowOffset = Size.headerStaackViewShadowOffset
	}
	
	private func createButtons(input: [String]) -> [UIButton] {
		var buttonArray = [UIButton]()
		var buttonTag = 0
		for item in input {
			let button = UIButton(type: .system)
			button.setTitle(item, for: .normal)
			button.setTitleColor(Constants.titleBtnColor, for: .normal)
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
			title: Constants.sortNavButton,
			style: .done,
			target: self,
			action: #selector(sortBtnAction)
		)
		navigationItem.leftBarButtonItem = leftButtonItem
		navigationItem.leftBarButtonItem?.tintColor = .black
	}
	
	@objc func allertUI(notification: NSNotification) {
		guard let allert = viewModel.allert(notification: notification) else { return }
		present(allert, animated: true)
	}
	
	@objc func tapToSort(sender: UIButton) {
		viewModel.animations.animateHeaderView(headerView: headerView, topConstraint: headerViewTopConstraint!, view: self)
		viewModel.sorted(tag: sender.tag)
		tableView.reloadData()
	}
	
	@objc func sortBtnAction() {
		viewModel.animations.animateHeaderView(headerView: headerView, topConstraint: headerViewTopConstraint!, view: self)
	}
}

//MARK: - LAYOUT

private extension MainView {
	func addSubview() {
		view.backgroundColor = .systemGray5
		view.addSubview(headerView)
		headerView.addSubview(headerStackView)
		view.addSubview(tableView)
	}
	
	func layout() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		
		headerViewTopConstraint = headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -Size.headerViewHeight)
		headerView.translatesAutoresizingMaskIntoConstraints = false
		headerView.heightAnchor.constraint(equalToConstant: Size.headerViewHeight).isActive = true
		headerViewTopConstraint!.isActive = true
		headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
		
		headerStackView.translatesAutoresizingMaskIntoConstraints = false
		headerStackView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 7).isActive = true
		headerStackView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -7).isActive = true
		headerStackView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 7).isActive = true
		headerStackView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -7).isActive = true
	}
}

//MARK: - DataSource
extension MainView: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: HotelCell.identifire, for: indexPath) as? HotelCell else {
			return UITableViewCell()
		}
		cell.viewModel = viewModel.cellViewModel(indexPath: indexPath)
		return cell
	}
}


//MARK: - Delegate
extension MainView: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.hotels.count
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		print(#function, indexPath.row)
		let hotel = viewModel.hotels[indexPath.row]
		let detailView = ModuleBuilder.createDetailView(hotel: hotel)
		navigationController?.show(detailView, sender: self)
	}
}
