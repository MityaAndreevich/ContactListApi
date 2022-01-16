//
//  ContactListViewController.swift
//  ContactListApi
//
//  Created by Dmitry Logachev on 15.12.2021.
//

import UIKit

class ContactListViewController: UITableViewController {
    
    private var randomContacts: [Results] = []
    
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
    
    //MARK: - Table View Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = randomContacts[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: user )
    }
    
    //MARK: - Navigtion
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? DetailsViewController else { return }
        detailsVC.contact = sender as? Results
    }
}

extension ContactListViewController {
    func fetchDataFor1() {
        NetworkManager.shared.fetchData(from: Link.linkFor1.rawValue) { result in
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
    
    func fetchContactFor10() {
        NetworkManager.shared.fetch(dataType: Contact.self, from: Link.linkFor10.rawValue) { result in
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
    
    func fetchDataFor50() {
        NetworkManager.shared.fetchData(from: Link.linkFor50.rawValue) { result in
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
}



