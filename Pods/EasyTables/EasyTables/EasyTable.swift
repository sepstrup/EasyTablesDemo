///**
/**
 * EasyTables
 * Created by: Peter Sepstrup on 1/9/17
 *
 * License: MIT
 */

import Foundation

public class EasyTable {
    
    /**
     This is needed to do updates to the view after rendering
     */
    var tableView: UITableView?
    
    public var sections: [TableSection] = []
    
    public var count: Int {
        get {
            return sections.count
        }
    }
    
    public var isEmpty: Bool {
        get {
            return count == 0
        }
    }
    
    public init() {
        
    }
    
    public init(tableView: UITableView) {
        self.tableView = tableView
    }
    
    
    
    public func section(at: Int) -> TableSection {
        return get(at: at)
    }
    
    public func at(index: Int) -> TableSection {
        return get(at: index)
    }
    
    public func get(at: Int) -> TableSection {
        return sections[at]
    }
    
    public func all() -> [TableSection] {
        return sections
    }
    
    public func add(section: TableSection) {
        sections.append(section)
    }
    
    public func add(section: TableSection, at: Int) {
        sections.insert(section, at: at)
    }
    
    public func remove(at: Int) {
        sections.remove(at: at)
    }
    
    public func remove(section: TableSection) {
        if let index = sections.index(of: section) {
            sections.remove(at: index)
        }
    }
    
    public func row(at: IndexPath) -> TableCellInfo {
        return self.at(index: at.section).row(at: at.row)
    }
    
    public func delete(section: Int) {
        sections.remove(at: section)
    }
    
    public func delete(row: IndexPath) {
        sections[row.section].rows.remove(at: row.row)
    }
    
    /**
     Add rows in the view, inserted with animation
     */
    public func addRowsBelow(indexPath: IndexPath, data: [TableCellInfo]) {
        guard let table = tableView else { return }
        let section = at(index: indexPath.section)
        section.rows.insert(contentsOf: data, at: indexPath.row+1)
        var newRows: [IndexPath] = []
        var newCount = 1
        for _ in data {
            newRows.append(IndexPath(row: indexPath.row+newCount, section: indexPath.section))
            newCount = newCount+1
        }
        table.beginUpdates()
        table.insertRows(at: newRows, with: .fade)
        table.endUpdates()
    }
    
    /**
     Remove rows in the view with animation, counterpart to addRowsBelow
     */
    public func removeRowsBelow(indexPath: IndexPath, numberOfRows: Int) {
        guard let table = tableView else { return }
        var delRows: [IndexPath] = []
        let section = at(index: indexPath.section)
        for i in 1...numberOfRows {
            section.rows.remove(at: indexPath.row+1)
            delRows.append(IndexPath(row: indexPath.row+i, section: indexPath.section))
        }
        table.beginUpdates()
        table.deleteRows(at: delRows, with: .fade)
        table.endUpdates()
    }
    
    /**
     removes rows above, optional include the sender (the gived indexpath), this is often used as a "done" button or similar
     */
    public func removeRowsAbove(indexPath: IndexPath, numberOfRows: Int, includeSender: Bool = false) {
        guard let table = tableView else { return }
        var delRows: [IndexPath] = []
        let section = at(index: indexPath.section)
        let delSender: Int = includeSender ? 0 : 1
        for i in delSender...(numberOfRows-1) {
            section.rows.remove(at: indexPath.row-i)
            delRows.append(IndexPath(row: indexPath.row-i, section: indexPath.section))
        }
        table.beginUpdates()
        table.deleteRows(at: delRows, with: .fade)
        table.endUpdates()
        
    }
    
}
