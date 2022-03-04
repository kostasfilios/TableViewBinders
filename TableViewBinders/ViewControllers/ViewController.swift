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
        self.binderDataSource = BinderDataSource(with: models)
        self.binderDataSource.bind(to: tableView)
    }

}

