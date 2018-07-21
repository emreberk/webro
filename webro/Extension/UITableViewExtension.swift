//
//  UITableViewExtension.swift
//  webro
//
//  Created by Emre Berk on 21.07.2018.
//  Copyright © 2018 Emre Berk. All rights reserved.
//

import UIKit

extension UITableView {
    
    // Hero Mode On:
    func register(cell: UITableViewCell.Type) {
        let nibName = String(describing: cell)
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: nibName)
    }
    
    func dequeue<T: UITableViewCell>() -> T {
        let className = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: className)! as! T
    }
    
    func register(headerFooterView: UITableViewHeaderFooterView.Type) {
        let nibName = String(describing: headerFooterView)
        let nib = UINib(nibName: nibName, bundle: nil)
        register(nib, forHeaderFooterViewReuseIdentifier: nibName)
    }
    
    func dequeueHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        let className = String(describing: T.self)
        return dequeueReusableHeaderFooterView(withIdentifier: className)! as! T
    }
    // Hero Mode Off:
}
