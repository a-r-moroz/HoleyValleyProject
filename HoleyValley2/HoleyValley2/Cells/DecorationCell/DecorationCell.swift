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
    
//    let database = Database.database().reference()
    
    var database: DatabaseReference!
    var decorationDescription = String()
    var decorations = [Decoration]()

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        decorationPictureView.layer.cornerRadius = decorationPictureView.frame.height / 10
//        contentView.backgroundColor = .black
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
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
            
//            self.decorationPictureView.setImageFromULR(value["picture"] as? String ?? Const.defaultImage)
//            self.decorationNameLabel.text = (value["name"] as? String ?? "")
//            self.decorationPriceLabel.text = String(value["price"] as? Int ?? 0) + " BYN"
//            self.decorationDescription = (value["description"] as? String ?? "")
//            print(self.decorationDescription)
            
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
            
//            self.decorations.append([value["picture"] as! String, value["name"] as? String ?? "", String(value["price"] as? Int ?? 0) + " BYN", (value["description"] as? String ?? "")])
        })
        
        //    var decorationItem = Decoration()
        
        //    guard let value = snapshot.value as? NSDictionary else { return }
        //
        //    self.decorationItem.name = (value["name"] as? String ?? "")
        //    self.decorationItem.price = (value["price"] as? String ?? "")
        //    self.decorationItem.describtion = (value["description"] as? String ?? "")
        //    self.decorationItem.image?.setImageFromULR((value["picture"] as! String))
        //
        //    self.decorationPictureView = self.decorationItem.image
        //    self.decorationNameLabel.text = self.decorationItem.name
        //    self.decorationPriceLabel.text = self.decorationItem.price
        //    self.decorationDescription = self.decorationItem.describtion!
        
        
//        let value = snapshot.value as? NSDictionary
//        self.decorationPictureView.setImageFromULR(value?["picture"] as? String ?? "")
//        self.decorationNameLabel.text = value?["name"] as? String ?? ""
//        self.decorationPriceLabel.text = value?["price"] as? String ?? ""

        
//        database.child("decorations").child("\(row)").observeSingleEvent(of: .value) { snapshot in
//            let value = snapshot.value as? NSDictionary
//            self.decorationNameLabel.text = value?["name"] as? String ?? ""
//            self.decorationPriceLabel.text = value?["price"] as? String ?? ""
//            self.decorationPictureView.setImageFromULR(value?["picture"] as? String ?? "")
//            self.decorationPictureView.contentMode = .scaleAspectFill
//            print(snapshot.value)
//
//        }
        
//        database.child("cat").setValue("Fffff")
//        decorationNameLabel.text = item.name
//        decorationPriceLabel.text = String(item.price) + " BYN"
//        decorationPictureView.image = UIImage(data: item.picture!)
    }
    
}
