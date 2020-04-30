//
//  MainViewController.swift
//  NYTimes
//
//  Created by Mohamed Ramadan on 4/26/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController,UIScrollViewDelegate {
    
    // MARK:- OutLets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var spinnerIndicator: UIActivityIndicatorView!
    
    let disposeBag = DisposeBag()
    var viewModel : ArticleViewModel = ArticleViewModel()
    var detailViewModel : ArticlesViewModel!
    
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
        self.tableview.delegate = nil
        self.tableview.dataSource = nil
        self.spinnerIndicator.startAnimating()
        self.bindViewModel()
        refreshTable()
        setupTableView()
        bindToTableView()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableview.reloadData()
    }
    
    func bindViewModel() {
    
        segmentedControl.rx.selectedSegmentIndex.subscribe(onNext: { (days) in
            self.viewModel.numberOfDays.accept(self.viewModel.getDays(selectedIndex: days))
            self.viewModel.fetchArticles.asObserver().onNext(()).self
            self.tableview.reloadData()
        }).disposed(by: disposeBag)
        self.refresherControl.endRefreshing()
        self.spinnerIndicator.stopAnimating()
        
    }
    
    func refreshTable() {
        
        tableview.refreshControl = refresherControl
        refresherControl.tintColor = #colorLiteral(red: 0.2784313725, green: 0.462745098, blue: 0.9019607843, alpha: 1)
        refresherControl.attributedTitle = NSAttributedString(string: "Refreshing News", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2784313725, green: 0.462745098, blue: 0.9019607843, alpha: 1), NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 16.0)!])
        
        self.refresherControl.endRefreshing()
        
        self.refresherControl.rx.controlEvent(.valueChanged).subscribe(onNext: { (_) in
            self.viewModel.fetchArticles.asObserver().onNext(())
            self.refresherControl.endRefreshing()
        }).disposed(by:disposeBag)
    }
    
    private func setupTableView() {
        
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 120
        tableview.register(UINib(nibName: "MainArticlesCell", bundle: nil), forCellReuseIdentifier: "MainArticlesCell")
    }
    
    private func bindToTableView(){
        
        viewModel.articles.bind(to: tableview.rx.items(cellIdentifier: "MainArticlesCell", cellType: MainArticlesCell.self)) { (row, articleElement, cell) in
            cell.configureUi(articleList: ArticlesViewModel(article: articleElement))
        }.disposed(by: disposeBag)
        
        tableview.rx.modelSelected(ArticlesList.self)
        .subscribe(onNext: { value in
            guard let detailsVC = self.storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController else { return  }
            detailsVC.articleDetails = value
            self.navigationController?.present(detailsVC, animated: true, completion: nil)
        }).disposed(by: disposeBag)
    }
    
}

