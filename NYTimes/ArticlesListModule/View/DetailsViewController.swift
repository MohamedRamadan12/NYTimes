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
    
    var article: Article?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.detailsLabel.text = article?.adxKeywords
        self.titleLabel.text = article?.title
    }
}
