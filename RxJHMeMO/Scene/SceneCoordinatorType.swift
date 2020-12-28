//
//  SceneCoordinatorType.swift
//  RxJHMeMO
//
//  Created by 송정훈 on 2020/12/28.
//

import Foundation
import RxSwift
protocol SceneCoordinatorType {
    @discardableResult
    func transition(to scene:Scene,using style:TransitionStyle,animated:Bool) -> Completable
    @discardableResult
    func close(animated:Bool) -> Completable

}
