//
//  ImagesListViewController.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 22.11.2022.
//

import UIKit

class ImagesListViewController: UIViewController {
    
    private var showSingleImageID = "ShowSingleImage"
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == showSingleImageID {
            let viewController = segue.destination as! SingleImageViewController
            let indexPath = sender as! IndexPath
            let image = UIImage(named: photoNames[indexPath.row])
            viewController.image = image
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}


// MARK: - TableView
extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: showSingleImageID, sender: indexPath)
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
        let config = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 24))
        let likeImage = UIImage(systemName: "heart.fill", withConfiguration: config)
        
        let imageName = photoNames[indexPath.row]
        if let imageName = UIImage(named: imageName) {
            cell.cellImage.image = imageName
            cell.dateLabel.text = dateFormatter.string(from: Date())
            let likeTintColor: UIColor = indexPath.row % 2 == 0 ? .ypWhiteAlpha50 : .ypRed
            cell.likeButton.setImage(likeImage?.withTintColor(likeTintColor,
                                                              renderingMode: .alwaysOriginal),
                                     for: .normal)
            
        } else {
            return
        }
        
    }
}
