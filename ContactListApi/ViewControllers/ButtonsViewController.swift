//
//  ButtonsViewController.swift
//  ContactListApi
//
//  Created by Dmitry Logachev on 16.12.2021.
//

import UIKit

enum UserActions: String, CaseIterable {
    case showContactList = "Show contact List"
    case sendContactListWithAlamo = "Send CL with Alamo"
    case showContactListWithAlamo = "Show CL with Alamo"
}

class ButtonsViewController: UICollectionViewController {
    
    let userActions = UserActions.allCases
    
    //private var data: ContactForSession!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: UICollectionViewDataSource
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "button", for: indexPath) as! ButtonsViewCell
    
        let userAction = userActions[indexPath.item]
        cell.userActionLabel.text = userAction.rawValue
        
        return cell
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
        case .showContactList: performSegue(withIdentifier: "urlSession", sender: nil)
        case .sendContactListWithAlamo: performSegue(withIdentifier: "alamoPost", sender: nil)
        case .showContactListWithAlamo: performSegue(withIdentifier: "alamoGet", sender: nil)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let contactsVC = segue.destination as! ContactListViewController
        switch segue.identifier {
        case "urlSession": contactsVC.fetchData()
        case "alamoPost": contactsVC.fetchContact()
        case "alamoGet": contactsVC.fetchData()
        default: break
        }
    }
}

