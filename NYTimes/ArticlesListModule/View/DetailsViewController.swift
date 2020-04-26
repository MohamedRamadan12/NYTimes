//
//  DetailsViewController.swift
//  NYTimes
//
//  Created by Azza on 4/26/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
    var articleDetails: ArticlesList?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI(articleDetails: articleDetails!)
    }
    
 
    func setupUI(articleDetails: ArticlesList){
        self.detailsLabel.text = articleDetails.adxKeywords
        self.titleLabel.text = articleDetails.title
    }
  

}
