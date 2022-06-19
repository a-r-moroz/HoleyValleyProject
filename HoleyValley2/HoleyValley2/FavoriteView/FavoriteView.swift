//
//  FavoriteView.swift
//  HoleyValley2
//
//  Created by Andrew Moroz on 19.06.22.
//

import UIKit

class FavoriteView: UIView {

    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet var contentView: UIView!
    
    weak var viewDelegate: FavoriteViewDelegate?
    
    // при изменении бул будет меняться состояние кнопки
    var isLiked: Bool = false {
        didSet {
            setupLike()
        }
    }
    
    private func commonInit() {
        
        let bundle = Bundle(for: FavoriteView.self)
        bundle.loadNibNamed(String(describing: FavoriteView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        setupLike()
        
        let likeTap = UITapGestureRecognizer(target: self, action: #selector(likeAction))
        favoriteImageView.addGestureRecognizer(likeTap)
    }
    
    // создание объекта через код
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        commonInit()
    }
    
    // создание объекта через сториборд или ксиб
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        commonInit()
    }
    
    @objc func likeAction() {
        
//        isLiked = !isLiked
        isLiked.toggle()
        viewDelegate?.likeAction()
    }
    
    private func setupLike() {
        
        favoriteImageView.image = isLiked ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        favoriteImageView.tintColor = isLiked ? Const.Colors.gold : Const.Colors.gold
    }
    
    func setupWith(condition: Bool) {
        
        self.isLiked = condition
    }

}
