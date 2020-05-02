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
import RxBiBinding

class MainViewController: UIViewController,UIScrollViewDelegate {
    
    // MARK:- OutLets
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var spinnerIndicator: UIActivityIndicatorView!
    
    let disposeBag = DisposeBag()
    var viewModel : ArticleViewModel = ArticleViewModel(clientAPI: ClientAPI())
//    var detailViewModel : ArticlesViewModel!
    
    let refresherControl = UIRefreshControl()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "NY Times"
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.5921568627, blue: 0.9568627451, alpha: 1)
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupTableView()
        self.bindViewModel()

        bindToTableView()
    }
    
    func bindViewModel() {
        (segmentedControl.rx.value <-> viewModel.days).disposed(by: disposeBag)
        refresherControl.rx.controlEvent(.valueChanged).bind(to: viewModel.shouldRefresh).disposed(by: disposeBag)
        viewModel.isRefreshing.bind(to: refresherControl.rx.isRefreshing, spinnerIndicator.rx.isAnimating).disposed(by: disposeBag)
        viewModel.articles
        .bind(to: tableview.rx.items(cellIdentifier: "MainArticlesCell", cellType: MainArticlesCell.self)) { (row, article, cell) in
            cell.configureUi(article: article)
        }.disposed(by: viewModel.disposeBag)

    }
    
    func setupTableView() {
        refresherControl.tintColor = #colorLiteral(red: 0.2784313725, green: 0.462745098, blue: 0.9019607843, alpha: 1)
        refresherControl.attributedTitle = NSAttributedString(string: "Refreshing News", attributes: [
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2784313725, green: 0.462745098, blue: 0.9019607843, alpha: 1),
            NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 16.0)!
        ])

        tableview.refreshControl = refresherControl
        tableview.delegate = nil
        tableview.dataSource = nil
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 120
        tableview.register(UINib(nibName: "MainArticlesCell", bundle: nil), forCellReuseIdentifier: "MainArticlesCell")

    }
    
    private func bindToTableView() {
        
        tableview.rx.modelSelected(Article.self)
            .subscribe(onNext: { value in
                guard let viewController = self.storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController else { return  }
                viewController.article = value
                self.navigationController?.present(viewController, animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    
}

