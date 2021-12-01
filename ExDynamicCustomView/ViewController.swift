//
//  ViewController.swift
//  ExDynamicCustomView
//
//  Created by 김종권 on 2021/12/01.
//

import UIKit
import RxDataSources
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    var sections = [
        MySection(headerTitle: "첫 번째", items: [MyModel(message: "jake"), MyModel(message:"jake의 iOS")]),
        MySection(headerTitle: "두 번째", items: [MyModel(message:"jake의 iOS앱 개발 알아가기"), MyModel(message:"jake의 iOS앱 개발 알아가기\njake의 iOS앱 개발 알아가기")]),
        MySection(headerTitle: "세 번째", items: [MyModel(message:"jake의 iOS앱 개발 알아가기\njake의 iOS앱 개발 알아가기\njake의 iOS앱 개발 알아가기\njake의 iOS앱 개발 알아가기")])
    ]
    
    var sectionSubject = BehaviorRelay(value: [MySection]())
    
    /// row 설정만 가능 (section은 dataSource.titleForHeaderInSection으로 설정)
    var dataSource = RxTableViewSectionedReloadDataSource<MySection> { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.className, for: indexPath) as! MyTableViewCell
        cell.bind(mySectionItem: item)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupTableViewDataSource()
        bindSubject()
    }
    
    private func setupViews() {
        let myTableViewCellNib = UINib(nibName: MyTableViewCell.className, bundle: nil)
        tableView.register(myTableViewCellNib, forCellReuseIdentifier: MyTableViewCell.className)
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func setupTableViewDataSource() {
        sectionSubject.accept(sections)
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].headerTitle
        }
    }
    
    private func bindSubject() {
        sectionSubject
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // RxTableViewSectionedReloadDataSource는 일반 dataSourec배열처럼 index로 접근 가능
        let data = dataSource[indexPath]
        let myModel = MyModel(message: data.message)

        let calculatedHeight = MyTableViewCell.height(width: tableView.layer.frame.size.width, myModel: myModel)
        return calculatedHeight
    }
}
