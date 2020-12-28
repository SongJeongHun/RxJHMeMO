//
//  Transition.swift
//  RxJHMeMO
//
//  Created by 송정훈 on 2020/12/28.
//

import Foundation
enum TransitionStyle{
    case root
    case push
    case modal
}
enum TransitionError:Error{
    case navigationControllerMissing
    case cannotPop
    case unknown
}

