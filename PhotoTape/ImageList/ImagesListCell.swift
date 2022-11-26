//
//  ImagesListCell.swift
//  PhotoTape
//
//  Created by Arsen Hachuk on 24.11.2022.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    static let reuseIdentifier = "ImagesListCell"
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!

}
