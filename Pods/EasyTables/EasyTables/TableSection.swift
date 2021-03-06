///**
/**
 * EasyTables
 * Created by: Peter Sepstrup on 1/9/17
 *
 * License: MIT
 */

import Foundation

public class TableSection: Equatable {
    
    public var title: String?
    public var rows: [TableCellInfo] = []
    private var uuid: String
    
    public var count: Int {
        get {
            return rows.count
        }
    }
    
    public var isEmpty: Bool {
        get {
            return count == 0
        }
    }
    
    public required init() {
        uuid = UUID().uuidString
    }
    
    public required init(title: String) {
        self.title = title
        uuid = UUID().uuidString
    }
    
    public required init(title: String, rows: [TableCellInfo]) {
        self.title = title
        self.rows = rows
        uuid = UUID().uuidString
    }
    
    public required init(rows: [TableCellInfo]) {
        self.rows = rows
        uuid = UUID().uuidString
    }
    
    public required init(title: String, rows: [String]) {
        var newRows = [TableCellInfo]()
        for s in rows {
            newRows.append(identifier: s)
        }
        self.title = title
        self.rows = newRows
        uuid = UUID().uuidString
    }
    
    public required init(rows: [String]) {
        var newRows = [TableCellInfo]()
        for s in rows {
            newRows.append(identifier: s)
        }
        self.rows = newRows
        uuid = UUID().uuidString
    }
    
    public static func ==(lhs: TableSection, rhs: TableSection) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    public func add(row: TableCellInfo) {
        rows.append(row)
    }
    
    public func add(rows: [TableCellInfo]) {
        self.rows.append(contentsOf: rows)
    }
    
    public func addAsFirst(row: TableCellInfo) {
        self.add(row: row, at: 0)
    }
    
    public func add(row: TableCellInfo, at: Int) {
        rows.insert(row, at: at)
    }
    
    public func add(rows: [TableCellInfo], at: Int) {
        self.rows.insert(contentsOf: rows, at: at)
    }
    
    public func add(row: String) {
        self.add(row: TableCellInfo(identifier: row))
    }
    
    public func add(row: String, at: Int) {
        self.add(row: TableCellInfo(identifier: row), at: at)
    }
    
    public func add(rows: [String]) {
        for s in rows {
            add(row: TableCellInfo(identifier: s))
        }
    }
    
    public func add(rows: [String], at: Int) {
        var newRows = [TableCellInfo]()
        for s in rows {
            newRows.append(identifier: s)
        }
        add(rows: newRows, at: at)
    }
    
    public func delete(row: Int) {
        rows.remove(at: row)
    }
    
    public func row(at: Int) -> TableCellInfo {
        return rows[at]
    }
    
    public func index(of: TableCellInfo) -> Int? {
        return rows.index(of: of)
    }
    
}
