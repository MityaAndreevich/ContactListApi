//
//  ContactListViewController.swift
//  ContactListApi
//
//  Created by Dmitry Logachev on 15.12.2021.
//

import UIKit

class ContactListViewController: UITableViewController {
    
    var randomContacts: [Results] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        randomContacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        
        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        content.imageProperties.cornerRadius = 50
        
        let contact = randomContacts[indexPath.row]
        let imageURL = contact.picture?.thumbnail
        let imageData = NetworkManager.shared.fetchImage(from: imageURL)
        
        content.text = contact.name?.last
        content.secondaryText = contact.name?.first
        content.image = UIImage(data: imageData!)
        
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
    func fetchData() {
        NetworkManager.shared.fetchData(from: Link.linkFor20.rawValue) { result in
            switch result {
            case .success(let contactForSession):
                print(contactForSession)
                self.randomContacts = contactForSession.results ?? []
                self.tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchContact() {
        NetworkManager.shared.fetch(dataType: ContactForSession.self, from: Link.linkFor20.rawValue) { result in
            switch result {
            case .success(let contactForSession):
                print(contactForSession)
                self.randomContacts = contactForSession.results ?? []
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}



