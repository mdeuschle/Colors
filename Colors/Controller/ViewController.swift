//
//  ViewController.swift
//  Colors
//
//  Created by Matt Deuschle on 6/29/19.
//  Copyright © 2019 Matt Deuschle. All rights reserved.
//

import UIKit

final class ViewController: UITableViewController {
    
    var colors = [Color]() {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        downloadColors()
        tableView.register(ColorCell.self, forCellReuseIdentifier: "ColorCell")
    }
    
    private func downloadColors() {
        WebService.shared.downloadColors { [weak self] success, colors in
            if success {
                self?.colors = colors!.sorted { $0.rank ?? 0 < $1.rank ?? 0 }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ColorCell",
                                                       for: indexPath) as? ColorCell else {
                                                        return ColorCell()
        }
        let color = colors[indexPath.row]
        cell.configure(with: color)
        return cell
    }
}

