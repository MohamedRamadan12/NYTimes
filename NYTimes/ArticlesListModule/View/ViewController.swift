//
//  ViewController.swift
//  NYTimes
//
//  Created by Mohamed Ramadan on 4/26/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var viewModel = ArticleViewModel()
    var articlesList: [ArticlesList] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.getArticlesList(numOfDays: .one, completion: { list in
            self.articlesList = list
            
        })
      
    }


}

