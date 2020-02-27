//
//  ExampleTableViewController.swift
//
//  IndoorAtlas iOS SDK Swift Examples
//

import UIKit
import SVProgressHUD

class ExampleTableViewController: UITableViewController {
    
    var examplesList = [String]()
    
    @IBAction func unwindToMenu(_ segue: UIStoryboardSegue) {}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        
        let userDefaults = UserDefaults.standard
        let barButton = UIBarButtonItem(title: "Normal mode", style: UIBarButtonItemStyle.plain, target: self, action: #selector(buttonClick(sender:)))
        let buttonTile = userDefaults.object(forKey: "mode") as? String
        if (buttonTile == "Low power mode"){
            barButton.title = buttonTile
        }
        
        self.navigationItem.rightBarButtonItem = barButton
        
        loadData()
        setUpHUD()
    }
    
    @objc func buttonClick(sender: UIBarButtonItem){
        let buttonTitle = self.navigationItem.rightBarButtonItem?.title
        let userDefaults = UserDefaults.standard
        if(buttonTitle == "Normal mode"){
            self.navigationItem.rightBarButtonItem?.title = "Low power mode"
            userDefaults.set("Low power mode", forKey: "mode")
        }else{
            self.navigationItem.rightBarButtonItem?.title = "Normal mode"
            userDefaults.set("Normal mode", forKey: "mode")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Loads the example titles which are same as segue IDs
    func loadData() {
        examplesList = ["Map View", "Image View"]
    }
    
    // Sets up the SVProgressHUD with a bit slower animation
    func setUpHUD() {
        SVProgressHUD.setFadeInAnimationDuration(0.6)
    }
    
    //
    // Normal table functions
    //
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examplesList.count
    }
    
    // Sets the label texts for the table cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ExampleTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ExampleTableViewCell
        let example = examplesList[indexPath.row]
        cell.labelForExamples.text = example
        return cell
    }
    
    // Identifier is same as the name in examplesList, that way the segue can be performed easily
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let identifier = examplesList[indexPath.row]
        performSegue(withIdentifier: identifier, sender: nil)
    }
    
    // Sets the title of the section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Positioning"
    }
}
