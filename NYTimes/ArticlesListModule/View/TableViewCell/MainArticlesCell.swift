//
//  MainArticlesCell.swift
//  NYTimes
//
//  Created by Azza on 4/26/20.
//  Copyright © 2020 Mohamed Ramadan. All rights reserved.
//

import UIKit

class MainArticlesCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var articleLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureUi(articleList: ArticlesViewModel) {
        titleLable.text = articleList.title
        articleLable.text = articleList.detail
    }
    
}
