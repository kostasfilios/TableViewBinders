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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTestBinderModels() 
    }

    //this is boilerplate code. maybe we could simplify this further
    private func setupBinderDataSource(from models: [BinderModelConformer]) {
        let binders = models.map{ $0.getCellType() }
        binderDataSource = BinderDataSource(with: binders)
        tableView.dataSource = binderDataSource
        tableView.delegate = binderDataSource
        tableView |> binderDataSource.registerNibs()
    }
    
    private func loadTestBinderModels() {
        let models = [TitleCellBinderModel(title: "Hello there"),
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
        setupBinderDataSource(from: models)
        (models, tableView) |> binderDataSource.submit()
    }

}

