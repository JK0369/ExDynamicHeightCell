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
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    var sections = [
        MySection(model: "첫 번째", items: [MyModel(message: "jake"), MyModel(message:"jake의 iOS")]),
        MySection(model: "두 번째", items: [MyModel(message:"jake의 iOS앱 개발 알아가기"), MyModel(message:"jake의 iOS앱 개발 알아가기\njake의 iOS앱 개발 알아가기")]),
        SectionModel(model: "세 번째", items: [MyModel(message:"jake의 iOS앱 개발 알아가기\njake의 iOS앱 개발 알아가기\njake의 iOS앱 개발 알아가기\njake의 iOS앱 개발 알아가기")])
    ]
    
    /// row 데이터 적용 (section은 dataSource.titleForHeaderInSection으로 설정)
    var dataSource = RxTableViewSectionedReloadDataSource<MySection> { dataSource, tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.className, for: indexPath) as! MyTableViewCell
        cell.bind(model: item)
        return cell
    }
    
    var sectionSubject = BehaviorRelay(value: [MySection]())
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTableViewDataSource()
        setupTableViewDelegate()
        addEditButtonToNavigationItem()
        bind()
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
            return dataSource.sectionModels[index].model
        }
    }
    
    private func setupTableViewDelegate() {
        tableView.rx.itemSelected
            .map { "셀 선택 indexPath = \($0)" }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(MySection.Item.self)
            .map { "셀 선택 model \n= \($0)" }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        Observable
            .zip(tableView.rx.itemSelected, tableView.rx.modelSelected(MySection.Item.self))
            .map { "셀 선택 \($0),\n\($1)" }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        tableView.rx.itemDeleted
            .map { "아이템 제거 = \($0)" }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        tableView.rx.itemMoved
            .map { "아이템 이동 \n= \($0)" }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    // viewDidLoad()에서 호출
    private func addEditButtonToNavigationItem() {
        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    private func bind() {
        sectionSubject
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        editButtonItem.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.toggleEditMode()
            }).disposed(by: disposeBag)
    }
    
    private func toggleEditMode() {
        let toggleEditMode = !tableView.isEditing
        tableView.setEditing(toggleEditMode, animated: true)
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
