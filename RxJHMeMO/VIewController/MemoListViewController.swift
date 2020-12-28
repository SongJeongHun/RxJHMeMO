//
//  MemoListViewController.swift
//  RxJHMeMO
//
//  Created by 송정훈 on 2020/12/28.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx

class MemoListViewController: UIViewController,ViewModelBindableType {
    var viewModel: MemoListViewModel!
    @IBOutlet weak var ListTableView:UITableView!
    @IBOutlet weak var addButton:UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func bindViewModel(){
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by:rx.disposeBag)
        viewModel.memoList
            .bind(to:ListTableView.rx.items(cellIdentifier: "cell")){row,memo,cell in
                
                cell.textLabel?.text = memo.content
            }
            .disposed(by: rx.disposeBag)
    }
}
