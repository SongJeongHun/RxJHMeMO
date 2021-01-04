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
}
