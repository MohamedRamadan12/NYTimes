//
//  MainViewController.swift
//  NYTimes
//
//  Created by Mohamed Ramadan on 4/26/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK:- OutLets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var spinnerIndicator: UIActivityIndicatorView!

    var viewModel = ArticleViewModel()
    let refresherControl = UIRefreshControl()
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "NY Times"
        self.navigationController?.isNavigationBarHidden = false
        super.viewWillAppear(true)
           self.navigationController?.navigationBar.prefersLargeTitles = true
           if #available(iOS 13.0, *) {
               let navBarAppearance = UINavigationBarAppearance()
               navBarAppearance.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.5921568627, blue: 0.9568627451, alpha: 1)
               self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
           }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.spinnerIndicator.stopAnimating()
        tableview.dataSource = self
        tableview.delegate = self
        callData()
        refreshTable()
        tableview.register(UINib(nibName: "MainArticlesCell", bundle: nil), forCellReuseIdentifier: "MainArticlesCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableview.reloadData()
    }
    
    @objc func callData() {
        viewModel.callApi(numberOfDayes: .one)
        self.tableview.reloadData()
        self.refresherControl.endRefreshing()
        self.spinnerIndicator.stopAnimating()
    }
    
    func refreshTable() {
        tableview.refreshControl = refresherControl
               refresherControl.tintColor = #colorLiteral(red: 0.2784313725, green: 0.462745098, blue: 0.9019607843, alpha: 1)
        refresherControl.attributedTitle = NSAttributedString(string: "Refreshing News", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2784313725, green: 0.462745098, blue: 0.9019607843, alpha: 1), NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 16.0)!])
               refresherControl.addTarget(self, action: #selector(callData), for: .valueChanged)
    }
    
fileprivate    func ActionSegmentPressed(numOfDays: Days) {
        self.spinnerIndicator.startAnimating()
        viewModel.callApi(numberOfDayes: numOfDays)
        self.tableview.reloadData()
        self.spinnerIndicator.stopAnimating()
    }
    @IBAction func filterSegmentedControl(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0 :
            self.ActionSegmentPressed(numOfDays: .one)
            return
        case 1:
        self.ActionSegmentPressed(numOfDays: .seven)
            return
        case 2 :
            self.ActionSegmentPressed(numOfDays: .thirty)
            return
        default:
            break
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.Articales?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = self.tableview.dequeueReusableCell(withIdentifier: "MainArticlesCell") as! MainArticlesCell
        guard let articale = viewModel.Articales?[indexPath.row] else { return cell }
        cell.configureUi(articleList: articale)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let articale = viewModel.Articales?[indexPath.row] else { return  }
        
        let detailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailController.articleDetails = articale
        self.navigationController?.present(detailController, animated: true)//pushViewController(detailController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.tableview.isDragging{
            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
}
