//
//  MainViewController.swift
//  NYTimes
//
//  Created by Mohamed Ramadan on 4/26/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableview: UITableView!
    
    
    var viewModel = ArticleViewModel()
    var articlesList: [ArticlesList] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        tableview.register(UINib(nibName: "MainArticlesCell", bundle: nil), forCellReuseIdentifier: "MainArticlesCell")

        viewModel.getArticlesList(numOfDays: .one, completion: { list in
            self.articlesList = list
            self.tableview.reloadData()
        })
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableview.reloadData()
    }
    
    @IBAction func filterSegmentedControl(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0 :
            viewModel.getArticlesList(numOfDays: .one, completion: { list in
                self.articlesList = list
                self.tableview.reloadData()
                
            })
            return
        case 1:
            viewModel.getArticlesList(numOfDays: .seven, completion: { list in
                self.articlesList = list
                self.tableview.reloadData()
                
            })
            return
        case 2 :
            viewModel.getArticlesList(numOfDays: .thirty, completion: { list in
                self.articlesList = list
                self.tableview.reloadData()
                
            })
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
        return articlesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = self.tableview.dequeueReusableCell(withIdentifier: "MainArticlesCell") as! MainArticlesCell
        cell.configureUi(articleList: articlesList[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleDetails = articlesList[indexPath.row]
        let detailController = UIStoryboard(name: "DetailsViewController", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailController.setupUI(articleDetails: articleDetails)
        self.navigationController?.pushViewController(detailController, animated: true)
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
