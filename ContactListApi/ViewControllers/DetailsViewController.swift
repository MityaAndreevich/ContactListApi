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
        
        contactName.text = setLabelText(with: "Name", and: contact.name?.first)
        contactSurname.text = setLabelText(with: "Surname", and: contact.name?.last)
        contactCell.text = setLabelText(with: "Cell", and: contact.cell)
        contactPhone.text = setLabelText(with: "Phone", and: contact.phone)
        contactEmail.text = setLabelText(with: "Email", and: contact.email)
    }
    
    private func setLabelText(with text: String, and parameter: String?) -> String {
        let stringParameter = String(parameter ?? "")
        let result = "\(text): \(stringParameter)"
        return result
    }
}
