//
//  ViewController.swift
//  carbs
//
//  Created by Oleksandr Khalupa on 01.08.2022.
//

import UIKit

class CalculateVC: UIViewController, UITextFieldDelegate {
    //    MARK: - @IBOutlet
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var indexSliderOut: UISlider!
    @IBOutlet weak var backgroundGender: UIImageView!
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet var genderButtonColelection: [UIButton]!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    private let infoLabel: UILabel = {
        let obj = UILabel()
        obj.font = .systemFont(ofSize: 15)
        obj.numberOfLines = 0
        obj.textColor = .white
        obj.textAlignment = .center
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    //    MARK: - Properties
    var indexGender:Float = 0.0
    var bmrBrain = BmrBrain()
    var isGender = false
    
    //    MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        heightTextField.delegate = self
        weightTextField.delegate = self
        ageTextField.delegate = self
        
        blurView.contentView.addSubview(infoLabel)
        setupInfoLabel()
        setupBlurView()
        
        setUI()
    }
    
    //    MARK: - Action
    
    @IBAction func indexSlider(_ sender: UISlider) {
        let value = String(format: "%.2f", sender.value)
        indexLabel.text = value
        if sender.value > 1 {
            setUI()
        }
    }
    
    @IBAction func genderButton(_ sender: UIButton) {
        if sender.tag == 0 {
            indexGender = 5
            sender.backgroundColor = .brown
            backgroundGender.image = UIImage(named: "man")
            isGender = false
            infoLabel.textColor = .white
            indexLabel.textColor = .white
            genderButtonColelection[1].backgroundColor = .white
        }
    
        if sender.tag == 1 {
            sender.backgroundColor = .magenta
            backgroundGender.image = UIImage(named: "woman")
            isGender = true
            indexGender = -161
            infoLabel.textColor = .black
            indexLabel.textColor = .black
            genderButtonColelection[0].backgroundColor = .white
        }
    }
    
    @IBAction func calculateButton(_ sender: UIButton) {
        enterData() // Checking the filling UI
    }
    
    //    MARK: - Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRecalculateVC" {
//             Before the transition, we make all the calculations
            let height = Float(heightTextField.text ?? "0") ?? 0
            let weight = Float(weightTextField.text ?? "0") ?? 0
            let age = Float(ageTextField.text ?? "0") ?? 0
            let index = indexSliderOut.value
            
            let recalculateVC = segue.destination as! RecalculateVC
            recalculateVC.bmrResults =  bmrBrain.getBMR(weight: weight, height: height, age: age, indexGender: indexGender, index: index)
            
            if isGender {
                recalculateVC.isGender = isGender
            }
        }
    }
    
    //    MARK: - TextFiel DELEGATE
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // We hide the keyboard pressing on Return/Done
        heightTextField.endEditing(true)
        weightTextField.endEditing(true)
        ageTextField.endEditing(true)
        return true
    }
    
    
    //    MARK: - SETUP UI
    func enterData() {
        if ageTextField.text == "" {
            ageTextField.placeholder = "Enter your age!"
        } else if weightTextField.text == "" {
            weightTextField.placeholder = "Enter your weight!"
        } else if heightTextField.text == "" {
            heightTextField.placeholder = "Enter your height!"
        } else if genderButtonColelection[0].backgroundColor == .white && genderButtonColelection[1].backgroundColor == .white{
            infoLabel.text = "Choose your gender!"
        } else if indexSliderOut.value < 1.19 {
            infoLabel.text = "Choose an activity coefficient!"
        } else {
            setUI()
            performSegue(withIdentifier: "toRecalculateVC", sender: self)
        }
    }
    
    
    private func setupBlurView() {
        let blurEffect = UIBlurEffect(style: .light)
        blurView.effect = blurEffect
        blurView.layer.cornerRadius = 10
        blurView.clipsToBounds = true
        blurView.layer.borderWidth = 1
        blurView.layer.borderColor = UIColor.lightGray.cgColor
        blurView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupInfoLabel() {
        infoLabel.topAnchor.constraint(equalTo: blurView.topAnchor).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: blurView.bottomAnchor).isActive = true
        infoLabel.leadingAnchor.constraint(equalTo: blurView.leadingAnchor).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor).isActive = true
    }
    
    func setUI(){
        infoLabel.text = "How to determine the activity factor:\n1.2 –  Minimum activity \n 1.4 – Small activity \n 1.46 – Average activity \n1.55 – Activity is higher than average \n 1.64 – Increased activity \n 1.72 – High activity \n 1.9 – Very high activity"
    }
}

