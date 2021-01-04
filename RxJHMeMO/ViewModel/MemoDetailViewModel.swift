//
//  MemoDetailViewModel.swift
//  RxJHMeMO
//
//  Created by 송정훈 on 2020/12/28.
//

import Foundation
import RxSwift
import RxCocoa
import Action
class MemoDetailViewModel:CommonViewModel{
    let memo:Memo
    private var formatter:DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "Ko_kr")
        f.dateStyle = .medium
        f.timeStyle = .medium
        return f
    }()
    var contents:BehaviorSubject<[String]>  //Behvoir로 선언해야하는 이유 다시 왓을때 정보
    init(memo:Memo,title:String,sceneCoordinator:SceneCoordinatorType,stoarge:MemoStorageType){
        self.memo = memo
        contents = BehaviorSubject<[String]>(value: [memo.content,formatter.string(from: memo.insertDate)])
        super.init(title: title, sceneCoordinator: sceneCoordinator, storage: stoarge)
    }
    lazy var popAction = CocoaAction{ [unowned self] in
        return self.sceneCoordinator.close(animated: true).asObservable().map{ _ in }
    }
    func performUpdate(memo:Memo) -> Action<String,Void>{
        return Action{input in
             self.storage.update(memo: memo, content: input)
                .subscribe(onNext:{updated in
                    self.contents.onNext([updated.content,self.formatter.string(from: updated.insertDate)])
                })
                .disposed(by: self.rx.disposeBag)
            return Observable.empty()
            //observable<void> 타입을 맞춰주기 위함
        }
    }
    func makeEditAction() -> CocoaAction{
        return CocoaAction { _ in
            let composeViewModel = MemoComposeViewModel(title: "Edit memo", content: self.memo.content, sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(memo: self.memo))
            let composeScene = Scene.compose(composeViewModel)
            return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map({_ in })
        }
    }
}
