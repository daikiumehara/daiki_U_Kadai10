//
//  ViewController.swift
//  Kadai10
//
//  Created by daiki umehara on 2021/09/13.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!

    private var viewModel: PrefecturesViewModel = PrefecturesViewModel(PrefecturesModel())
    private let disposeBag = DisposeBag()
    private var prefectures = [String]()
    private let colorDatas: [UIColor] =  [#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)]

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupBinding()
        viewModel.viewDidLoad()
    }

    private func configureTableView() {
        self.tableView.register(PrefectureCell.nib,
                                forCellReuseIdentifier: PrefectureCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    func setupBinding() {
        viewModel.prefecturesObservable
            .asDriver(onErrorDriveWith: .empty())
            .drive(onNext: { [weak self] prefectures in
                self?.prefectures = prefectures
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.prefectures.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PrefectureCell.identifier) as? PrefectureCell else {
            fatalError("PrefectureCellが見つかりませんでした")
        }
        cell.configure(name: prefectures[indexPath.row],
                       index: indexPath.row + 1,
                       color: colorDatas[indexPath.row % 3])
        return cell
    }
}

