//
//  ScheduleTableViewCell.swift
//  EventsDemoApp
//
//  Created by Edwin Weru on 05/08/2022.
//

import Kingfisher
import UIKit

class ScheduleTableViewCell: UITableViewCell {
    @IBOutlet private var img_view: UIImageView!

    @IBOutlet private var lbl_title: UILabel!
    @IBOutlet private var lbl_desc: UILabel!
    @IBOutlet private var lbl_time: UILabel!

    static let reuseIdentifier: String = "ScheduleTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "ScheduleTableViewCell", bundle: nil)
    }

    func configure(with model: ScheduleModel) {
        lbl_title.text = model.title
        lbl_desc.text = model.subtitle

        lbl_time.text = model.date

        guard let imgUrl = URL(string: model.imageUrl) else {
            return
        }

        img_view?.kf.setImage(
            with: imgUrl,
            placeholder: UIImage(named: "icon-events"),
            options: [
                .loadDiskFileSynchronously,
                .cacheOriginalImage,
                .transition(.fade(0.25))
            ],
            progressBlock: { _, _ in
                // Progress updated
            },
            completionHandler: { _ in
                // Done
            }
        )
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
