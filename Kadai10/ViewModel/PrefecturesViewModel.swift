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
    private var prefectures = BehaviorRelay<[String]>(value: [])
    var prefecturesObservable: Observable<[String]> {
        prefectures.asObservable()
    }
    private let disposeBag = DisposeBag()
    private let model: ModelProtocol

    init(_ model: ModelProtocol) {
        self.model = model
    }

    func viewDidLoad() {
        model.fetchDatas()
            .bind(to: prefectures)
            .disposed(by: disposeBag)
    }
}
