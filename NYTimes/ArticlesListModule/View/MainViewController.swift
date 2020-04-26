//
//  MainViewController.swift
//  NYTimes
//
//  Created by Mohamed Ramadan on 4/26/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
 

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableview: UITableView!
    
    
    var viewModel = ArticleViewModel()
    var articlesList: [ArticlesList] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        tableview.delegate = self
        viewModel.getArticlesList(numOfDays: .one, completion: { list in
            self.articlesList = list
        })
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 5
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         <#code#>
     }
     
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         if self.tableview.isDragging{
             cell.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
             UIView.animate(withDuration: 0.3, animations: {
                 cell.transform = CGAffineTransform.identity
             })
         }
     }
    
    
    
    
    

    @IBAction func filterSegmentedControl(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0 :
            return
        case 1:
            return
        case 2 :
            return
        default:
            break
        }
        
    }
    
    
}

