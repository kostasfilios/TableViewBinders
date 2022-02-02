//
//  ViewController.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 1/2/22.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    private var binderDataSource: BinderDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinderDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTestBinderModels()
    }

    private func setupBinderDataSource() {
        let binders = [ImageCellBinderTableViewCell(),
                       TitleCellBinderTableViewCell()]
        binderDataSource = BinderDataSource(with: binders)
        tableView.dataSource = binderDataSource
        tableView.delegate = binderDataSource
        tableView |> binderDataSource.registerNibs()
    }
    
    private func loadTestBinderModels() {
        let test = [TitleCellBinderModel(),
                    ImageCellBinderModel(),
                    ImageCellBinderModel(),
                    TitleCellBinderModel(),
                    ImageCellBinderModel(),
                    ImageCellBinderModel(),
                    ImageCellBinderModel(),
                    ImageCellBinderModel()]
        (test, tableView) |> binderDataSource.submit()
    }

}

