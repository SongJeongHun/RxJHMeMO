//
//  MemoListViewModel.swift
//  RxJHMeMO
//
//  Created by 송정훈 on 2020/12/28.
//

import Foundation
import RxSwift
import RxCocoa
class MemoListViewModel:CommonViewModel{
    var memoList:Observable<[Memo]>{
        return storage.memoList()
    }
}
