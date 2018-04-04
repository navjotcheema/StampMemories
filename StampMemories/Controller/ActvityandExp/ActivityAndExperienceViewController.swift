//
//  ActivityAndExperienceViewController.swift
//  StampMemories
//
//  Created by Apple on 03/02/18.
//  Copyright © 2018 Apple. All rights reserved.
// test

import UIKit
import GooglePlaces

class ActivityAndExperienceViewController: BaseViewController,UISearchBarDelegate {
    var booleanValue :Bool!
    var selecteValue : IndexPath!
    @IBOutlet weak var activityExpTableView: UITableView!

    
    let reuseIdentifier = "cellCollectionView" // also enter this string as the cell identifier in the storyboard
    var items = ["Movies", "Lessons", "Tutoring", "Art", "Science"]

    
    var arrayCellIdentifier = ["cellColection","cell"]
    
    override func viewDidLoad()
    {
        booleanValue =  false
        selecteValue =  IndexPath(row: 0, section: 0)
        let sampleSearchBar =  UISearchBar(frame: CGRect(x: 20, y: 100, width: self.view.frame.size.width, height: 40))
        sampleSearchBar.text =  "Current Location"
        sampleSearchBar.backgroundColor =  UIColor.init(hexString: navBarColor)
        sampleSearchBar.layer.cornerRadius = 5
        sampleSearchBar.delegate  = self
        self.navigationItem.titleView =  sampleSearchBar

        activityExpTableView.backgroundColor = UIColor.clear
        super.viewDidLoad()
        setNavigationBarItem()
        var buttonImage :UIImage =  UIImage(named:"filter")!
        let rightButton: UIBarButtonItem = UIBarButtonItem(image: buttonImage, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.toggleRight))
        navigationItem.rightBarButtonItem = rightButton
        
        
        // Do any additional setup after loading the view.
    }
    
    func googlePlace()
    {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        present(autocompleteController, animated: true, completion: nil)
        
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        googlePlace()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        googlePlace()

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - UICollectionViewDataSource protocol

}
extension  ActivityAndExperienceViewController : UICollectionViewDataSource,UICollectionViewDelegate
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath as IndexPath) as! customCollectionViewCell
        cell.parentCategoryLabel.text  =  items [indexPath.row]
        
     
        
        print(selecteValue)
     
       
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        selecteValue =  indexPath
        booleanValue = true
        let cell : customCollectionViewCell = collectionView.cellForItem(at: indexPath as IndexPath) as! customCollectionViewCell
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
        cell.indicatorImage.backgroundColor =  UIColor.init(hexString: navBarColor)
        print("You selected cell #\(indexPath.item)!")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell : customCollectionViewCell = collectionView.cellForItem(at: indexPath as IndexPath) as! customCollectionViewCell
        
        cell.indicatorImage.backgroundColor =  UIColor.clear
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension ActivityAndExperienceViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let viewFooter :UIView =  UIView()
        viewFooter.frame =  CGRect(x: 0, y: 0, width: 0, height: 0)
        return viewFooter
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        print(section)
        
        let labelName :UILabel =  UILabel()
        if section == 0
        {
            labelName.text =  "Activities"
        }
        else
        {
            labelName.text =  "Experiences"
        }
        labelName.frame =  CGRect(x: 10, y: 10, width: self.view.frame.size.width, height: 30)
        labelName.textColor =  UIColor.init(hexString: navBarColor)
        let viewheader :UIView =  UIView()
        viewheader.frame =  CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40)
        viewheader.backgroundColor = UIColor.clear
        viewheader.addSubview(labelName)
        return viewheader
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let identifiertext =  arrayCellIdentifier[indexPath.row]
        if identifiertext == "cellColection"
        {
            return 80
        }
        else
        {
            return 440
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(indexPath.section)
        let identifiertext =  arrayCellIdentifier[indexPath.row]
        let cell : dashBoardTableViewCell  =  tableView.dequeueReusableCell(withIdentifier:identifiertext )  as! dashBoardTableViewCell
        cell.selectionStyle =  UITableViewCellSelectionStyle.none
        return cell
    }
}
extension ActivityAndExperienceViewController: GMSAutocompleteViewControllerDelegate {
    
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {

        print("Place name: \(place.name)")
        print("Place address: \(String(describing: place.formattedAddress))")
        print("Place attributions: \(String(describing: place.attributions))")
        dismiss(animated: true, completion: nil)
       // strlocation =  place.formattedAddress!
        //convertAddressIntoLatLong(address: strlocation)
        //regTableView.reloadData()
        
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
