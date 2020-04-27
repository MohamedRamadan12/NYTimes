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
    
    func configureUi(articleList: ArticlesList) {
        let article = articleList.abstract
        let nsString = article as NSString
        if nsString.length >= 10
        {
            // When you use things that are is not self explanatory,

            // extract as a variable, and give a descriptive name
            // Or write a comment describing what is happening
            articleLable.text = "\(nsString.substring(with: NSRange(location: 0, length: nsString.length > 20 ? 20 : nsString.length)))   ... click to continue"
        }
        titleLable.text = articleList.title
    }

 
}
