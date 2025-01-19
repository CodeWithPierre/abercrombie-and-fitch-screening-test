//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

class ANFExploreCardTableViewController: UITableViewController {
    let viewModel: ANFExploreCardTableViewControllerViewModel
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
        self.fetchExploreCards()
    }
    
    private  func registerReausableCell() {
        tableView.register(ANFExploreCardTableViewCell.self, forCellReuseIdentifier: ViewModel.cellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    // Fetch products from ViewModel
    @objc private func fetchExploreCards() {
        viewModel.getExploreCard { [weak self] error in
            if error != nil {
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true)
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
        let cell: ANFExploreCardTableViewCell = tableView.dequeueReusableCell(withIdentifier: ViewModel.cellIdentifier,
                                                                              for: indexPath) as! ANFExploreCardTableViewCell
        let exploreData = viewModel.exploreCard[indexPath.row]
        cell.configure(topDescription: exploreData.topDescription ?? "",
                       title: exploreData.title ?? "",
                       promoMessage: exploreData.promoMessage ?? "",
                       bottomDescription: exploreData.bottomDescription ?? "",
                       image: exploreData.backgroundImage, shopMenButtonTitle: ViewModel.shopMentext,
                       shopWomenButtonTitle: ViewModel.shopWomentext)
        return cell
    }
}
