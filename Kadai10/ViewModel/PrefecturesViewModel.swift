//
//  ViewModel.swift
//  Kadai10
//
//  Created by daiki umehara on 2021/09/13.
//

import Foundation
import RxSwift
import RxCocoa

class PrefecturesViewModel {
    private var prefectures = PublishSubject<[String]>()
    var prefecturesObservable: Observable<[String]> {
        prefectures.asObserver()
    }
    private let model: ModelProtocol

    init(_ model: ModelProtocol) {
        self.model = model
    }

    func fetchData() {
        let event = model.fetchDatas()
        switch event {
        case .next(let array):
            self.prefectures.onNext(array)
        case .error: break
        case .completed: break
        }
    }
}
