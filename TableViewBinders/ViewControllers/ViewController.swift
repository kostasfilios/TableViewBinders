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
                       ImageCellBinderStructTableViewCell(),
                       TitleCellBinderTableViewCell(),
                       TitleCellBinderStructTableViewCell()]
        binderDataSource = BinderDataSource(with: binders)
        tableView.dataSource = binderDataSource
        tableView.delegate = binderDataSource
        tableView |> binderDataSource.registerNibs()
    }
    
    private func loadTestBinderModels() {
        let test = [TitleCellBinderModel(title: "Hello there"),
                    ImageCellBinderModel(),
                    ImageCellBinderModel(),
                    TitleCellBinderModel(title: "tester"),
                    ImageCellBinderModel(),
                    ImageCellBinderModel(),
                    ImageCellBinderModel(),
                    ImageCellBinderModel(),
                    TitleCellBinderModelStruct(title: "Hey"),
                    TitleCellBinderModelStruct(title: "I"),
                    ImageCellBinderModelStruct(),
                    ImageCellBinderModelStruct(),
                    TitleCellBinderModelStruct(title: "test"),
                    ImageCellBinderModelStruct(),
                    TitleCellBinderModelStruct(title: "structs"),
                    ImageCellBinderModelStruct(),
                    TitleCellBinderModelStruct(title: "binders"),
                    ImageCellBinderModelStruct(),
                    ImageCellBinderModelStruct()] as [BinderModelConformer]
        (test, tableView) |> binderDataSource.submit()
    }

}

