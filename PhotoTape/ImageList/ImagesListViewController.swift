//
//  ImagesListViewController.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 22.11.2022.
//

import UIKit

class ImagesListViewController: UIViewController {
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    @IBOutlet private var tableView: UITableView!
    private var photoNames = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoNames = Array(0..<20).map{"\($0)"}
    }
}


// MARK: - TableView
extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier,
                                                 for: indexPath)
        
        guard let imageListCell = cell as? ImagesListCell else {
            assertionFailure("не удалось скастить ячейку в (ImagesListViewController)")
            return UITableViewCell()
        }
        
        configCell(for: imageListCell, with: indexPath)
        
        return imageListCell
    }
}
// MARK: - Конфигурация ячейки
extension ImagesListViewController {
  
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        let imageName = photoNames[indexPath.row]
        if let imageName = UIImage(named: imageName) {
            cell.cellImage.image = imageName
            cell.dateLabel.text = dateFormatter.string(from: Date())
            if indexPath.row % 2 == 0 {
                cell.likeButton.setImage(UIImage(named: "No Active"), for: .normal)
            } else {
                cell.likeButton.setImage(UIImage(named: "Favorit Active"), for: .normal)
            }
        } else {
            return
        }
        
    }
}
