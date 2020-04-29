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
    var viewModel: ArticleViewModel = ArticleViewModel()

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
        tableview.register(UINib(nibName: "MainArticlesCell", bundle: nil), forCellReuseIdentifier: "MainArticlesCell")
        bindToTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableview.reloadData()
    }
    
    func bindViewModel() {
        
        viewModel.numberOfDays.accept(Days(index: segmentedControl.selectedSegmentIndex)!)
//                segmentedControl.rx.selectedSegmentIndex
//                articleViewModel = ArticleViewModel(numOfDays:
//                    .map {Days(index: $0) ?? .one}
//                    .asDriver(onErrorJustReturn: .one))
//                articleViewModel.articales.drive(onNext: { [weak self](_) in
//                    self?.tableview.reloadData()
//                    }).disposed(by: disposeBag)
        self.refresherControl.endRefreshing()
        self.spinnerIndicator.stopAnimating()
        setupTableView()
    }
    
    func refreshTable() {
        tableview.refreshControl = refresherControl
        refresherControl.tintColor = #colorLiteral(red: 0.2784313725, green: 0.462745098, blue: 0.9019607843, alpha: 1)
        refresherControl.attributedTitle = NSAttributedString(string: "Refreshing News", attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2784313725, green: 0.462745098, blue: 0.9019607843, alpha: 1), NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 16.0)!])
//        refresherControl.rx.controlEvent(.valueChanged).bind(to: viewModel.fetchArticles).disposed(by: disposeBag)
        refresherControl.addTarget(self, action: #selector(callData), for: .valueChanged)
    }
    
    private func setupTableView() {
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 120
        tableview.register(UINib(nibName: "MainArticlesCell", bundle: nil), forCellReuseIdentifier: "MainArticlesCell")
    }
    
    private func bindToTableView(){
        viewModel.articles.bind(to: tableview.rx.items(cellIdentifier: "MainArticlesCell", cellType: MainArticlesCell.self)) { (row, articleElement, cell) in
//            cell.articleLable.text = articleElement.adxKeywords
//            cell.titleLable.text = articleElement.title
            cell.configureUi(articleList: articleElement)
        }.disposed(by: disposeBag)
    }
    
    @objc func callData(){
//        viewModel.fetchArticles.subscribe(onNext:{
//            print("Fetching---")
//            }).dispose()
    }
}
//     fileprivate func ActionSegmentPressed(numOfDays: Days) {
//        self.spinnerIndicator.startAnimating()
//        viewModel.callApi(numberOfDayes: segmentedControl.rx.selectedSegmentIndex
//        self.tableview.reloadData()
//        self.spinnerIndicator.stopAnimating()
//    }
//    @IBAction func filterSegmentedControl(_ sender: Any) {
//        switch segmentedControl.selectedSegmentIndex {
//        case 0 :
//            self.ActionSegmentPressed(numOfDays: .one)
//            return
//        case 1:
//        self.ActionSegmentPressed(numOfDays: .seven)
//            return
//        case 2 :
//            self.ActionSegmentPressed(numOfDays: .thirty)
//            return
//        default:
//            break
//        }
//    }
//}

//extension MainViewController:  UITableViewDelegate {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.articles.value.count
//    }
//
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////        let cell = tableview.dequeueReusableCell(withIdentifier: "MainArticlesCell", for: indexPath) as! MainArticlesCell
////
//////
//////        if let viewModel = viewModel.viewModelForArticle(at: indexPath.row) {
//////            cell.configureUi(article: Article)
//////        }
////        return cell
////    }
//
//    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    //        guard let articale = viewModel.articales?[indexPath.row] else { return  }
//    //
//    //        let detailController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
//    //        detailController.articleDetails = articale
//    //        self.navigationController?.present(detailController, animated: true)//pushViewController(detailController, animated: true)
//    //    }
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if self.tableview.isDragging {
//            cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
//            UIView.animate(withDuration: 0.3, animations: {
//                cell.transform = CGAffineTransform.identity
//            })
//        }
//    }
//}


