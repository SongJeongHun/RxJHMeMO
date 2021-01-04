//
//  MemoDetailViewController.swift
//  RxJHMeMO
//
//  Created by 송정훈 on 2020/12/28.
//

import UIKit

class MemoDetailViewController: UIViewController,ViewModelBindableType {
    @IBOutlet weak var editButton: UIToolbar!
    @IBOutlet weak var deleteButton: UIToolbar!
    @IBOutlet weak var shareButton: UIToolbar!
    @IBOutlet weak var listTableView: UITableView!
    var viewModel: MemoDetailViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        viewModel.contents
            .bind(to: listTableView.rx.items){tableView,row,value in
                switch row{
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell")!
                    cell.textLabel?.text = value
                    return cell
                case 1:
                    let cell  = tableView.dequeueReusableCell(withIdentifier: "dateCell")!
                    cell.textLabel?.text = value
                    return cell
                default:
                    fatalError()
                }
            }
            .disposed(by: rx.disposeBag)
//        var backButton = UIBarButtonItem(title: nil, style: .done, target: nil, action: nil)
//        viewModel.title
//            .drive(backButton.rx.title)
//            .disposed(by: rx.disposeBag)
//        backButton.rx.action = viewModel.popAction
//        navigationItem.hidesBackButton = true
//        navigationItem.leftBarButtonItem = backButton
    }
    

}
