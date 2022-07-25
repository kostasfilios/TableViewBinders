
# TableViewBinders

We propose the usage of Binder Adapters in order to have a data driven behaviour. 
With this way we can achieve a more clean an elegant implementation of TableView cells based on binded models. 
We use models as unique identifiers for cells, with this way we can achieve one to one link between models and cell.

## Cell type

```
final class TitleCellBinderTableViewCell: BinderCell 
```

## Model type

```
final class TitleCellBinderModel: BinderModel
```

## Submit data list 

```
(dataList, tableView) |> binderDataSource.submitList()
```

## Add pending update 

```
dataList |> binderDataSource.setPendingData()
tableView |> binderDataSource.submitPendingUpdate()
```

## Pending List
Mutliple sections 

## Authors

- [@kostasfilios](https://github.com/kostasfilios)

