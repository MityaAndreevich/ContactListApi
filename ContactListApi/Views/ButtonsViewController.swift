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
        case "urlSession": contactsVC.fetchContacts()
        case "alamoPost": contactsVC.fetchContacts()
        case "alamoGet": contactsVC.fetchContacts()
        default: break
        }
        
    }
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
