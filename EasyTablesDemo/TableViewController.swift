///**
/**
 * EasyTables
 * Created by: Peter Sepstrup on 1/9/17
 *
 * License: MIT
 */

import UIKit
import EasyTables

//for easier use, extend EasyTableViewController, get count methods and table property with it
class TableViewController: EasyTableViewController {
    
    var showMore: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // add 2 sections with 3 rows each
        for i in 0...1 {
            let section = TableSection(title: "Section \(i)")
            for x in 0...2 {
                section.add(row: TableCellInfo(identifier: "Row \(x)"))
            }
            table.add(section: section)
        }
        
        //add a section with one row "Show more", we will use this later
        let section = TableSection()
        section.add(row: TableCellInfo(identifier: "Show more"))
        table.add(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        // Configure our cells
        switch table.row(at: indexPath).identifier {
            
        // The special row with its own class for example
        case "Special Row":
            // get data from our CellData, conforms to protocol TableCellData
            guard let data = table.row(at: indexPath).data as? CellData else { break }
            cell = tableView.dequeueReusableCell(withIdentifier: "subtitle", for: indexPath)
            // special class for our special cell (nothing special... :-)
            guard let specialCell = cell as? SpecialTableViewCell else { break }
            specialCell.textLabel?.text = table.row(at: indexPath).identifier
            specialCell.detailTextLabel?.text = data.subTitle
        // default cell
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "basic", for: indexPath)
            cell?.textLabel?.text = table.row(at: indexPath).identifier
        }
        
        // If we managed to build a cell return it - if somehow not, return a clean empty cell (should never happen)
        if let returnCell = cell {
            return returnCell
        } else {
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = table.row(at: indexPath)
        // handle selection of rows - show more row acts as a button
        switch row.identifier {
        case "Show more":
            // showMore is a Bool used to toggle
            if !showMore {
                // CellData for example
                let data = CellData()
                data.subTitle = "Special subtitle"
                // New rows, including a special one containing data
                let newRows = [
                    TableCellInfo(identifier: "New row"),
                    TableCellInfo(identifier: "Special Row", data: data),
                    TableCellInfo(identifier: "Done")
                ]
                // Add rows below the Show More row
                table.addRowsBelow(indexPath: indexPath, data: newRows)
            } else {
                // If the rows are allready there, remove them
                table.removeRowsBelow(indexPath: indexPath, numberOfRows: 3)
            }
            showMore = !showMore
        // Done also acts as a button
        case "Done":
            // Remove 3 rows including the sender (aka. the Done row)
            table.removeRowsAbove(indexPath: indexPath, numberOfRows: 3, includeSender: true)
            showMore = false
        default:
            return
        }
    }


}
