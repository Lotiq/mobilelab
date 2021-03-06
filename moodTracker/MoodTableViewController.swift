//
//  MoodTableViewController.swift
//  moodTracker
//
//  Created by Timothy on 2/16/19.
//  Copyright © 2019 Timothy. All rights reserved.
//

import UIKit

private let moodArrayKey = "MOOD_ARRAY_KEY"

class MoodTableViewController: UITableViewController {
    
    var moods = [Mood]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        if let data = UserDefaults.standard.value(forKey: moodArrayKey) as? Data {
            
            let moodArray = try? PropertyListDecoder().decode(Array<Mood>.self, from: data)
            self.moods = moodArray!
            self.tableView.reloadData()
        }
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: nil)
        cancelButton.tintColor = UIColor(red: 242/255, green: 222/255, blue: 43/255, alpha: 1)
        self.navigationItem.backBarButtonItem = cancelButton
        
        self.tableView.separatorColor = UIColor(red: 242/255, green: 222/255, blue: 43/255, alpha: 1)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moods.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "moodCell", for: indexPath) as! MoodTableViewCell

        let moodInstance = moods[indexPath.row]
        
        cell.commentLabel.text = moodInstance.message
        cell.dateLabel.text = moodInstance.date
        cell.moodImageView.image = UIImage(named: moodInstance.imageName)

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? MoodAddViewController else {
            print("Failed to instantiate mood VC")
            return
        }
        vc.didSaveMood = { [weak self] mood in
            
            self?.moods.append(mood)
            // Resave element array into User defaults.
            UserDefaults.standard.set(try? PropertyListEncoder().encode(self?.moods), forKey: moodArrayKey)
            
            self?.tableView.reloadData()
        }
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            moods.remove(at: indexPath.row)
            // Resave element array into User defaults.
            UserDefaults.standard.set(try? PropertyListEncoder().encode(moods), forKey: moodArrayKey)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
