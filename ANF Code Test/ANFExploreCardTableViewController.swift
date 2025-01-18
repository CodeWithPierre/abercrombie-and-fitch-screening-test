//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

class ANFExploreCardTableViewController: UITableViewController {
    private let viewModel: ANFExploreCardTableViewControllerViewModel
    typealias ViewModel = ANFExploreCardTableViewControllerViewModel
    
    init(viewModel: ANFExploreCardTableViewControllerViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = ANFExploreCardTableViewControllerViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerReausableCell()
        self.fetchProducts()
    }
    
    private  func registerReausableCell() {
        tableView.register(ANFExploreCardTableViewCell.self, forCellReuseIdentifier: "ANFExploreCardTableViewCell")
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    
    // Fetch products from ViewModel
    @objc private func fetchProducts() {
        viewModel.getExploreCard { [weak self] error in
            if error != nil {
                // Do something, either triger alert or log error
            } else {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.exploreCard.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ANFExploreCardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ANFExploreCardTableViewCell", for: indexPath) as! ANFExploreCardTableViewCell
        let exploreData = viewModel.exploreCard[indexPath.row]
        cell.configure(topDescription: exploreData.topDescription ?? "",
                       title: exploreData.title ?? "",
                       promoMessage: exploreData.promoMessage ?? "",
                       bottomDescription: exploreData.bottomDescription ?? "",
                       image: exploreData.backgroundImage, shopMenButtonTitle: "Shop Men",
                       shopWomenButtonTitle: "Shop Women")
        return cell
    }
}
