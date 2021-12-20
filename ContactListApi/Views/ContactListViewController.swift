//
//  ContactListViewController.swift
//  ContactListApi
//
//  Created by Dmitry Logachev on 15.12.2021.
//

import UIKit

class ContactListViewController: UITableViewController {
    
    private var contacts: [Contact] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        let contact = contacts[indexPath.row]
        
        content.text = contact.name?.last
        content.secondaryText = contact.phone
        
        cell.contentConfiguration = content
        return cell
    }
   

    
//MARK: - Navigtion
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

extension ContactListViewController {
    func fetchContacts() {
        NetworkManager.shared.fetchUser(from: Link.linkFor1.rawValue) { result in
            switch result {
            case .success(let contact):
                print(contact)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
