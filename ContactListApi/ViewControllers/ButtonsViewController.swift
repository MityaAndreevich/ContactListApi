//
//  ButtonsViewController.swift
//  ContactListApi
//
//  Created by Dmitry Logachev on 16.12.2021.
//

import UIKit

enum UserActions: String, CaseIterable {
    case showContactList = "Show contact List for 1"
    case showContactListFor10 = "Show contact list for 10"
    case showContactListFor50 = "Show contact list for 50"
}

class ButtonsViewController: UICollectionViewController {
    
    let userActions = UserActions.allCases
    
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
        case .showContactList: performSegue(withIdentifier: "clFor1", sender: nil)
        case .showContactListFor10: performSegue(withIdentifier: "clFor10", sender: nil)
        case .showContactListFor50: performSegue(withIdentifier: "clFor50", sender: nil)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let contactsVC = segue.destination as! ContactListViewController
        switch segue.identifier {
        case "clFor1": contactsVC.fetchDataFor1()
        case "clFor10": contactsVC.fetchContactFor10()
        case "clFor50": contactsVC.fetchDataFor50()
        default: break
        }
    }
}

