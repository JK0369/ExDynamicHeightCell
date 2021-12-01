//
//  ViewController.swift
//  ExDynamicCustomView
//
//  Created by 김종권 on 2021/12/01.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var messageDataSource = ["jake",
                             "jake의 iOS",
                             "jake의 iOS앱 개발 알아가기",
                             "jake의 iOS앱 개발 알아가기\njake의 iOS앱 개발 알아가기",
                             "jake의 iOS앱 개발 알아가기\njake의 iOS앱 개발 알아가기\njake의 iOS앱 개발 알아가기",
                             "jake의 iOS앱 개발 알아가기\njake의 iOS앱 개발 알아가기\njake의 iOS앱 개발 알아가기\njake의 iOS앱 개발 알아가기"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    private func setupViews() {
        let myTableViewCellNib = UINib(nibName: MyTableViewCell.className, bundle: nil)
        tableView.register(myTableViewCellNib, forCellReuseIdentifier: MyTableViewCell.className)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.className, for: indexPath) as! MyTableViewCell
        let myModel = MyModel(message: messageDataSource[indexPath.row])
        cell.bind(myModel: myModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = messageDataSource[indexPath.row]
        let myModel = MyModel(message: message)
        
        let calculatedHeight = MyTableViewCell.height(width: tableView.layer.frame.size.width, myModel: myModel)
        return calculatedHeight
    }
}
