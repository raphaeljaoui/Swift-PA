//
//  ServicesController.swift
//  LinkSAppIOS
//
//  Created by Imane on 30/04/2020.
//  Copyright © 2020 imane. All rights reserved.
//


import UIKit


protocol ListServicesViewControllerDelegate: class {
    func typeTap(id_type: Int)
}

class ImagesCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let typeServiceWS: TypeServiceWebService = TypeServiceWebService()
    
    weak var Typesdelegate: ListServicesViewControllerDelegate?
    
    var listTypeService: [TypeService]? {
        didSet {
            collectionView.reloadData()
        }
    }
     
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 30
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
     
    let cellId = "cellId"
     
    override init(frame: CGRect) {
        super.init(frame:frame)
        
        self.typeServiceWS.getTypesService{ (typesServices) in
            print(typesServices)
            if(typesServices.count > 0){
                self.listTypeService = typesServices
                self.setup()
            }
        }
        
    }
     
    func setup(){
        addSubview(collectionView)
        collectionView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
         
        collectionView.dataSource = self
        collectionView.delegate = self
         
        collectionView.register(IconsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.showsHorizontalScrollIndicator = false
    }
     
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let img = self.listTypeService {
            return img.count
        }
        return 0
    }
     
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! IconsCell
        
        
        guard let namePicture = listTypeService?[indexPath.item].picture else {
            cell.imageView.image = UIImage(named: "undefied")
            
            return cell
        }
        cell.imageView.image = UIImage(named: namePicture)
        
        
        return cell
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: frame.height - 20)
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let typeService = listTypeService?[indexPath.item] else { return }
        
        guard let td = Typesdelegate else { return }
        td.typeTap(id_type: typeService.id)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    private class IconsCell: UICollectionViewCell {
         
        let imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.clipsToBounds = true
            iv.layer.cornerRadius = 15
            return iv
        }()
         
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
         
        func setup() {
            addSubview(imageView)
            imageView.setAnchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        }
         
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    
    }
}


class AlbumCell: UICollectionViewCell {
    
    var images: [Service]? {
        didSet {
            //collectionView.reloadData()
        }
    }
     
    override init(frame: CGRect) {
        super.init(frame:frame)
        backgroundColor = .gray
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
