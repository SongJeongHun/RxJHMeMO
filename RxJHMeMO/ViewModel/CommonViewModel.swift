//
//  CommonViewModel.swift
//  RxJHMeMO
//
//  Created by 송정훈 on 2020/12/28.
//

import Foundation
import RxSwift
import RxCocoa
class CommonViewModel:NSObject{
    let title: Driver<String>
    let sceneCoordinator:SceneCoordinatorType
    let storage:MemoStorageType
    init(title:String,sceneCoordinator:SceneCoordinatorType,storage:MemoStorageType){
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.sceneCoordinator = sceneCoordinator
        self.storage = storage
    }
    
}
