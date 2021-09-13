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
    private let disposeBag = DisposeBag()

    private var prefecturesRelay = BehaviorRelay<[String]>(value: [])
    var prefecturesObservable: Observable<[String]> {
        prefecturesRelay.asObservable()
    }

    private let model: PrefecturesModelProtocol

    init(_ model: PrefecturesModelProtocol) {
        self.model = model
    }

    func viewDidLoad() {
        model.fetchDatas()
            .bind(to: prefecturesRelay)
            .disposed(by: disposeBag)
    }
}
