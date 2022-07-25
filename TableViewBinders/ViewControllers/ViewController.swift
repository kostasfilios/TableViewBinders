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
        let photoOfTheDay = "https://apod.nasa.gov/apod/image/2207/FindTheMoon_soltanolkotabi_1080.jpg"
        let test = [ImageCellBinderModel(photoOfTheDay),
                    ImageCellBinderModel(photoOfTheDay),
                    TitleCellBinderModel(title: "Hey"),
                    ImageCellBinderModel(photoOfTheDay),
                    ImageCellBinderModel(photoOfTheDay),
                    ImageCellBinderModel(photoOfTheDay),
                    ImageCellBinderModel(photoOfTheDay),
                    TitleCellBinderModel(title: "this"),
                    TitleCellBinderModel(title: "is"),
                    ImageCellBinderModel(photoOfTheDay),
                    ImageCellBinderModel(photoOfTheDay),
                    TitleCellBinderModel(title: "NASA's"),
                    ImageCellBinderModel(photoOfTheDay),
                    TitleCellBinderModel(title: "Photo of"),
                    ImageCellBinderModel(photoOfTheDay),
                    TitleCellBinderModel(title: "The day"),
                    ImageCellBinderModel(photoOfTheDay),
                    ImageCellBinderModel(photoOfTheDay)]
        (test, tableView) |> binderDataSource.submitList()
    }

}

