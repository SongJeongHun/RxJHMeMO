//
//  MemoComposeViewController.swift
//  RxJHMeMO
//
//  Created by 송정훈 on 2020/12/28.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx

class MemoComposeViewController: UIViewController ,ViewModelBindableType{
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var contentTextView: UITextView!
    var viewModel: MemoComposeViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        viewModel.initalText
            .drive(contentTextView.rx.text)
            .disposed(by: rx.disposeBag)
        cancelButton.rx.action = viewModel.cancelAction
        saveButton.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(contentTextView.rx.text.orEmpty)
            .bind(to:viewModel.saveAction.inputs)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentTextView.becomeFirstResponder()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if contentTextView.isFirstResponder{
            contentTextView.resignFirstResponder()
        }
    }

}
