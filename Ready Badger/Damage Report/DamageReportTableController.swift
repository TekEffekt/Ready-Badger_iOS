//
//  DamageReportTableController.swift
//  Ready Badger
//
//  Created by Kyle Zawacki on 10/17/16.
//  Copyright © 2016 App Factory. All rights reserved.
//

import UIKit

class DamageReportTableController: FormTableViewController, DefaultTheme, MenuItem, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var menu: HamburgerMenu?
    let damageReportDatasource = DamageReportDataSource()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = damageReportDatasource
        imagePicker.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme()
        view.tintColor = UIColor.tint()
        damageReportDatasource.tableView = tableView
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if damageReportDatasource.dateSelectMode && indexPath.section == 0 && indexPath.row == 2 {
            return 216
        } else {
            return 44
        }
    }
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let userEnteredString = textField.text
        let newString = (userEnteredString! as NSString).replacingCharacters(in: range, with: string)
        save(string: newString, forCellType: getCellForTextField(textfield: textField).type)
        
        return true
    }
    
    func getCellForTextField(textfield: UITextField) -> DamageReportCell {
        let containerView = textfield.superview!
        return containerView.superview! as! DamageReportCell
    }
    
    func save(string: String, forCellType type: DamageReportCellType) {
        switch type {
            case .name:
                damageReportDatasource.damageReport.name = string
            case .phoneNumber:
                damageReportDatasource.damageReport.phoneNumber = string
            case .address:
                damageReportDatasource.damageReport.address = string
            case .city:
                damageReportDatasource.damageReport.city = string
            case .zipCode:
                damageReportDatasource.damageReport.zipCode = string
            case .insuranceDeductible:
                damageReportDatasource.damageReport.insuranceDeductible = string
            case .percentLoss:
                damageReportDatasource.damageReport.percentOfLoss = string
            case .damageEstimate:
                damageReportDatasource.damageReport.damageEstimate = string
            case .waterInches:
                damageReportDatasource.damageReport.inchesOfWater = string
            default:
                break
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 1 {
            damageReportDatasource.dateSelectMode = !damageReportDatasource.dateSelectMode
            tableView.beginUpdates()
            if damageReportDatasource.dateSelectMode {
                tableView.insertRows(at: [IndexPath(row: 2, section: 0)], with: .fade)
            } else {
                tableView.deleteRows(at:  [IndexPath(row: 2, section: 0)], with: .fade)
            }
            tableView.endUpdates()
        } else if indexPath.section == 7 && indexPath.row == 1 {
            let sheet = AlertFactory.createActionSheet(cameraAction: { (action) in
                self.launchCamera()
            }, libraryAction: { (action) in
                self.openCameraLibrary()
            }, removeAction: { (action) in
                self.removeImage()
            })
            present(sheet, animated: true, completion: nil)
        }
    }
    
    @IBAction func sendPressed(_ sender: UIBarButtonItem) {
        let errors = DamageReportValidator.validate(report: damageReportDatasource.damageReport)
        damageReportDatasource.errors = errors
        
        if errors.isEmpty {
            if let image = damageReportDatasource.damageReport.picture {
                guard let imageData = UIImageJPEGRepresentation(image, 1) else { return }
                let request = ImageAlbumRequest(withImageData: imageData)
                NetworkQueue.shared.addOperation(ImageAlbumOperation(withRequest: request, andDamageReport: damageReportDatasource.damageReport))
            } else {
                
            }
        } else {
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        if let footer = view as? UITableViewHeaderFooterView {
            footer.textLabel?.textColor = UIColor.red
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let optionVc = segue.destination as? OptionController {
            switch segue.identifier! {
                case DamageReportSegues.DisasterTypeSegue.rawValue:
                    optionVc.options = DisasterType.getAll().map() {type in return type.rawValue}
                    if let type = damageReportDatasource.damageReport.disasterType {
                        optionVc.selectedRow = DisasterType.getAll().index(of: type)
                    }
                    optionVc.saveOptions = { [weak self] (option: String) in
                        self?.damageReportDatasource.damageReport.disasterType = DisasterType(rawValue: option)
                        self?.tableView.reloadData()
                    }
                case DamageReportSegues.StateSegue.rawValue:
                    optionVc.options = State.list
                    optionVc.saveOptions = { [weak self] (option: String) in
                        self?.damageReportDatasource.damageReport.state = option
                        self?.tableView.reloadData()
                }
                case DamageReportSegues.OwnershipOptions.rawValue:
                    optionVc.options = Answer.getAll().map() {answer in return answer.rawValue}
                    optionVc.saveOptions = { [weak self] (option: String) in
                        self?.damageReportDatasource.damageReport.ownership = Answer(rawValue: option)!
                        self?.tableView.reloadData()
                    }
                case DamageReportSegues.ResidenceHabitable.rawValue:
                    optionVc.options = Answer.getAll().map() {answer in return answer.rawValue}
                    optionVc.saveOptions = { [weak self] (option: String) in
                        self?.damageReportDatasource.damageReport.residenceIsHabitable = Answer(rawValue: option)!
                        self?.tableView.reloadData()
                    }
                case DamageReportSegues.ShowLivingOptions.rawValue:
                    optionVc.options = Answer.getAll().map() {answer in return answer.rawValue}
                    optionVc.saveOptions = { [weak self] (option: String) in
                        self?.damageReportDatasource.damageReport.personLivingInBasement = Answer(rawValue: option)!
                        self?.tableView.reloadData()
                    }
                default:
                    break
            }
        } else if let descriptionVc = segue.destination as? DescriptionViewController {
            descriptionVc.descriptionString = damageReportDatasource.damageReport.description
            descriptionVc.completionHandler = { [weak self] (descriptionString: String?) in
                self?.damageReportDatasource.damageReport.description = descriptionString
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: Camera
    func launchCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            imagePicker.modalPresentationStyle = .fullScreen
            present(imagePicker,animated: true,completion: nil)
        } else {
            noCamera()
        }
    }
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.default,
            handler: nil)
        alertVC.addAction(okAction)
        present(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    func openCameraLibrary() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker, animated: true, completion: nil)
    }
    
    func removeImage() {
        damageReportDatasource.damageReport.picture = nil
        tableView.reloadData()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var  chosenImage = UIImage()
        chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        damageReportDatasource.damageReport.picture = chosenImage
        dismiss(animated:true, completion: nil)
        tableView.reloadData()
    }

}
