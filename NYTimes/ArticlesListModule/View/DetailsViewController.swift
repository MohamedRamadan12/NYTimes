//
//  DetailsViewController.swift
//  NYTimes
//
//  Created by Azza on 4/26/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UIScrollViewDelegate {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var articleDetails: ArticlesList?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self

        setupUI(articleDetails: articleDetails!)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.x = 0
    }
    func setupUI(articleDetails: ArticlesList){
        self.detailsLabel.text = articleDetails.adxKeywords
        self.titleLabel.text = articleDetails.title
    }
  

}
