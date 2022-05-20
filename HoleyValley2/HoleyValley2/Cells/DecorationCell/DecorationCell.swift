//
//  DecorationCell.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 3.05.22.
//

import UIKit
import Firebase

class DecorationCell: UITableViewCell {

    @IBOutlet weak var decorationPictureView: UIImageView!
    @IBOutlet weak var decorationNameLabel: UILabel!
    @IBOutlet weak var decorationPriceLabel: UILabel!
        
//    var database: DatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        decorationPictureView.layer.cornerRadius = decorationPictureView.frame.height / 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /*
    func setupCell(row: Int) {
        
        decorationPictureView.image = UIImage(named: "defaultImage")
        decorationPictureView.contentMode = .scaleAspectFill
        
        database = Database.database().reference()
        database.child("decorations").child("\(row)").getData(completion: { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            guard let value = snapshot.value as? NSDictionary else { return }
            
            let item = Decoration(name: value["name"] as? String ?? "",
                                  price: value["price"] as? Int ?? 0,
                                  describtion: value["description"] as? String ?? "",
                                  image: value["picture"] as? String ?? Const.defaultImage
            )
            self.decorationPictureView.setImageFromULR(item.image)
            self.decorationNameLabel.text = item.name
            self.decorationPriceLabel.text = String(item.price) + " BYN"
            self.decorationDescription = item.describtion
            
            self.decorations.append(item)

        })
    }
     */
    
}
