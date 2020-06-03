//
//  ProfilFormController.swift
//  LinkSAppIOS
//
//  Created by Imane on 12/05/2020.
//  Copyright © 2020 imane. All rights reserved.
//

import UIKit
import AVFoundation

class ProfilFormController: UIViewController {
    
    var imagePicker: UIImagePickerController?
    var flashMode = AVCaptureDevice.FlashMode.off
    
    
    func configUI() {
        navigationItem.title = "Modifier mes informations"
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = .gray
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private var imageViewTake: UIImageView = {
        var someImageView = ScaledHeightImageView()

        someImageView.clipsToBounds = true

        someImageView.contentMode = .scaleAspectFit
        someImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        return someImageView
    }()
    
    private var TakeImageButton: UIButton = {
        var button = UIButton(type: .custom)
        button.setImage(UIImage(named: "photo-camera"), for: .normal)
        button.layer.zPosition = 2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(takePhoto(_:)), for: .touchUpInside)
        
        return button
    }()
    
    
    let userName: UITextField = UITextField(frame: CGRect(x: 230, y:320, width: 400.00, height: 50.00))
    
    let Prenom: UITextField = UITextField(frame: CGRect(x:230
        , y:400, width: 400.00, height: 50.00))
    
    let mail: UITextField = UITextField(frame: CGRect(x:230, y:480, width: 400.00, height: 50.00))
    
    let adresse: UITextField = UITextField(frame: CGRect(x:230, y:560, width: 400.00, height: 50.00))
    
     
    func sendButton() {
        let button = UIButton();
        button.setTitle("Envoyer", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.frame = CGRect(x: 380, y: 600, width: 100, height: 88)
        self.view.addSubview(button)
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configUI()
        addSubView()
        setupConstraints()
        displayForm()
        sendButton()
        
    }

     func displayForm(){
            userName.placeholder = "Votre nom"
            userName.borderStyle = UITextField.BorderStyle.line
            userName.backgroundColor = UIColor.white
            userName.textAlignment = .center
    //        userName.center = CGPoint(x: 200, y: 500)
            self.view.addSubview(userName)
            
            Prenom.placeholder = "Votre prenom"
            Prenom.borderStyle = UITextField.BorderStyle.line
            Prenom.backgroundColor = UIColor.white
            Prenom.textAlignment = .center
            self.view.addSubview(Prenom)
            
            mail.placeholder = "Votre email"
            mail.borderStyle = UITextField.BorderStyle.line
            mail.backgroundColor = UIColor.white
            mail.textAlignment = .center
            self.view.addSubview(mail)
            
            adresse.placeholder = "Votre adresse"
            adresse.borderStyle = UITextField.BorderStyle.line
            adresse.backgroundColor = UIColor.white
            adresse.textAlignment = .center
            self.view.addSubview(adresse)
            

        }
        
   @objc fileprivate func takePhoto(_ seder: UIButton!) {
    guard  UIImagePickerController.isSourceTypeAvailable(.camera) else {
        selectImageFrom(.photoLibary)
        return
    }
    selectImageFrom(.camera)
    TakeImageButton.setTitle("Take a Image", for: .normal)
    
    }
    
    
    func selectImageFrom(_ source: ImageSource) {
        imagePicker = UIImagePickerController()
       
        guard let imagePicker = imagePicker else { return }
        
        imagePicker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        switch  source {
        case .camera:
            imagePicker.sourceType = .camera
       
        case .photoLibary:
            imagePicker.sourceType = .photoLibrary
            
        }
        
        present(imagePicker, animated: true, completion: nil)
    }
    

    fileprivate func addSubView() {

        [TakeImageButton, imageViewTake, ].forEach{view.addSubview(($0))}
    }
    
    //MARK: - Constraints
    fileprivate func setupConstraints() {
        
        //ChoseOrTakeImageButton Constraint
        TakeImageButton.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: nil, trailing: nil, padding: .init(top: 0, left: 0, bottom: 16, right: 0), size: .init(width: 50, height: 50))
        
        TakeImageButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //ImageViewTake Constraint
        imageViewTake.anchor(top: view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, padding: .init(top: 159, left: 0, bottom: 0, right: 0), size: .init(width: 80, height: 150))
        
    }

}


extension ProfilFormController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        guard let imagePicker = imagePicker else { return }
        
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Item not found!")
            return
        }
        imageViewTake.image = selectedImage
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}


