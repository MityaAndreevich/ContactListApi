//
//  DetailsViewController.swift
//  ContactListApi
//
//  Created by Dmitry Logachev on 08.01.2022.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var contactImageView: UIImageView! {
        didSet {
            contactImageView.layer.cornerRadius = contactImageView.frame.height / 2
        }
    }
    
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactSurname: UILabel!
    @IBOutlet weak var contactCell: UILabel!
    @IBOutlet weak var contactPhone: UILabel!
    @IBOutlet weak var contactEmail: UILabel!
    
    var contact: Results!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(with: contact)
    }
    
    private func setValue(with result: Results) {
        let imageURL = contact.picture?.large
        guard let imageData = NetworkManager.shared.fetchImage(from: imageURL) else { return }
        self.contactImageView.image = UIImage(data: imageData)
        
        contactName.text = contact.name?.first
        contactSurname.text = contact.name?.last
        contactCell.text = contact.cell
        contactPhone.text = contact.phone
        contactEmail.text = contact.email
    }
}
