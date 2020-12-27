//
//  Memo.swift
//  RxJHMeMO
//
//  Created by 송정훈 on 2020/12/27.
//

import Foundation
struct Memo:Equatable{
    var content:String
    var insertDate:Date
    var identity:String //메모 구분
    init(content:String, insertDate:Date = Date()){
        self.content = content
        self.insertDate = insertDate
        self.identity = "\(insertDate.timeIntervalSinceReferenceDate)"
    }
    init(original:Memo,updatedContent:String){
        self = original
        self.content = updatedContent
    }
}
