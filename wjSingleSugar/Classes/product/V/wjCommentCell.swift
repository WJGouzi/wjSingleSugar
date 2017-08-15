//
//  wjCommentCell.swift
//  wjSingleSugar
//
//  Created by jerry on 2017/8/15.
//  Copyright © 2017年 wangjun. All rights reserved.
//

import UIKit
import Kingfisher

class wjCommentCell: UITableViewCell {
    
    // 属性
    @IBOutlet weak var headImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var commentModel : wjCommentModel? {
        didSet {
            if let url = commentModel!.user!.avatar_url {
                headImageView.kf.setImage(with: URL(string : url), placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            }
            nickNameLabel.text = commentModel!.user!.nickname
            contentLabel.text = commentModel!.content
            timeLabel.text = wjTimeStampToDate(commentModel!.created_at!)
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}


extension wjCommentCell {
    
    func wjTimeStampToDate(_ timeStamp : Int) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "chengdu")
        formatter.dateStyle = .medium
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        return formatter.string(from: date)
    }
    
}

