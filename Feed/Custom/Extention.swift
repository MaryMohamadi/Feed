//
//  Extention.swift
//  Feed
//
//  Created by Maryam Alimohammadi on 2/16/20.
//  Copyright © 2020 Maryam Alimohammadi. All rights reserved.
//

import UIKit

// MARK: - CoreData
public extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}

// MARK: - UITableView+UITableViewCell

public protocol ReusableView: class {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
extension UITableViewCell{
    func configureCell<T>(model:T){}
}
public protocol NibLoadableView: class {}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}


extension UITableView {
    func register<T: UITableViewCell> (_: T.Type) where  T: NibLoadableView {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell <T :UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath ) as? T else {
            fatalError("coudnot load cell with \(T.reuseIdentifier)")
        }
        return cell
    }
}

//MARK: - define deferent types for tiles

enum TileTypes: String{
    case image = "image"
    case video = "video"
    case website = "website"
    case shopping_list = "shopping_list"
    
}
