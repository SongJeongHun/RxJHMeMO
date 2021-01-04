//
//  MemoListViewModel.swift
//  RxJHMeMO
//
//  Created by 송정훈 on 2020/12/28.
//
/*struct Element {
var element: BehaviorSubject<Int>
}
...
            disposeBag = DisposeBag()
    // 초기 element 1, 2, 3
    let element1 = Element(element: BehaviorSubject(value: 1))
    let element2 = Element(element: BehaviorSubject(value: 2))
    let element3 = Element(element: BehaviorSubject(value: 3))
    let finalSequence = PublishSubject<Element>()
    // transform된 element를 subscribe한다. 이벤트가 발생할시 값을 출력
    finalSequence
        .flatMap { $0.element }
        .subscribe(onNext: {
            print($0 * 10)
        })
        .disposed(by: disposeBag)
    finalSequence.onNext(element1)
    finalSequence.onNext(element2)
    finalSequence.onNext(element3)
    element1.element.onNext(4)
            element2.element.onNext(5)
            finalSequence.dispose()
/*
10
20
30
40
50
*/
*/
import Foundation
import RxSwift
import RxCocoa
import Action
class MemoListViewModel:CommonViewModel{
    var memoList:Observable<[Memo]>{
        return storage.memoList()
    }
    func performUpdate(memo:Memo) -> Action<String,Void>{
        return Action{input in
            return self.storage.update(memo: memo, content: input).map{ _ in } //observable<void> 타입을 맞춰주기 위함
        }
    }
    func performCancel(memo:Memo) -> CocoaAction{
        return Action{
            return self.storage.delete(memo: memo).map{ _ in }
        }
    }
    func makeCreateAction() -> CocoaAction{
        return CocoaAction{_ in
            return self.storage.createMemo(content: "")
                .flatMap{ memo -> Observable<Void> in
                    let composeViewModel = MemoComposeViewModel(title: "New memo", sceneCoordinator: self.sceneCoordinator, storage: self.storage, saveAction: self.performUpdate(memo: memo), cancelAction: self.performCancel(memo: memo))
                    let composeScene = Scene.compose(composeViewModel)
                    return self.sceneCoordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map{ _ in }
                }
        }
    }
    lazy var detailAction: Action<Memo,Void> = {
        return Action { memo in
            let detailViewModel = MemoDetailViewModel(memo: memo, title: "Memo View", sceneCoordinator: self.sceneCoordinator, stoarge: self.storage)
            let detailScene = Scene.detail(detailViewModel)
            return self.sceneCoordinator.transition(to: detailScene, using: .push, animated: true).asObservable().map{ _ in }
        }
    }()
    
}
