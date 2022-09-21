//
//  CalculateViewController.swift
//  carbs
//
//  Created by Oleksandr Khalupa on 01.08.2022.
//

import UIKit

class RecalculateVC: UIViewController {
    //    MARK: - @IBOutlet
    @IBOutlet weak var maintainingLabel: UILabel!
    @IBOutlet weak var backgroundGender: UIImageView!
    @IBOutlet weak var targetSegmented: UISegmentedControl!
    @IBOutlet weak var resultBlurView: UIVisualEffectView!
    @IBOutlet weak var targetBlurView: UIVisualEffectView!
    @IBOutlet weak var buyButton: UIButton!
    
    private let resultLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    private let targetLabel: UILabel = {
        let obj = UILabel()
        obj.translatesAutoresizingMaskIntoConstraints = false
        return obj
    }()
    
    //    MARK: - Properties
    private var bmrBrain = BmrBrain()
    var isGender: Bool?
    var bmrResults: [BMR] = []
    
    //    MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        if let isBuy = UserDefaults.standard.value(forKey: "isBuy") as? Bool {
            if isBuy {
                buyButton.isHidden = true
                maintainingLabel.isHidden = true
                targetSegmented.isHidden = false
            }
        }
        
        resultBlurView.contentView.addSubview(resultLabel)
        targetBlurView.contentView.addSubview(targetLabel)
        setupUI()
        setupUI(numberOfSegment: 1)
    }
    
    //    MARK: - Action & Methods
    @IBAction func actionTargetSegmnted(_ sender: UISegmentedControl) {
        let numberOfSegment = targetSegmented.selectedSegmentIndex
        setupUI(numberOfSegment: numberOfSegment)
    }
    
    private func setupUI(numberOfSegment: Int) {
        let result = bmrResults[numberOfSegment]
        resultLabel.text = "Your calorie norm:\n\(bmrBrain.formatData(result.bmr)) kcal"
        targetLabel.text = "Remedible indicator:\n Protein: \(bmrBrain.formatData(result.protein)) gr\n Fats: \(bmrBrain.formatData(result.fats)) gr\n Carbs: \(bmrBrain.formatData(result.carbs)) gr"
    }
    
    @IBAction func recalculateButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pressedBuy(_ sender: UIButton) {
        sender.isHidden = true
        UserDefaults.standard.set(true, forKey: "isBuy")
        maintainingLabel.isHidden = true
        targetSegmented.isHidden = false
    }
    
    //    MARK: - SETUP UI
    private func setupUI() {
        setupBlurView(resultBlurView)
        setupBlurView(targetBlurView)
        
        if isGender == true {
            backgroundGender.image = UIImage(named: "woman")
            resultLabel.textColor = .black
            targetLabel.textColor = .black
        }
        maintainingLabel.layer.cornerRadius = 5
        maintainingLabel.layer.masksToBounds = true
        
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        targetSegmented.setTitleTextAttributes(titleTextAttributes, for:.normal)
        let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.black]
        targetSegmented.setTitleTextAttributes(titleTextAttributes1, for:.selected)
        targetSegmented.layer.borderColor = UIColor.gray.cgColor
        targetSegmented.layer.borderWidth = 1
        
        setupLabel(resultLabel, inView: resultBlurView)
        setupLabel(targetLabel, inView: targetBlurView)
    }
    
    private func setupBlurView(_ view: UIVisualEffectView) {
        let blurEffect = UIBlurEffect(style: .light)
        view.effect = blurEffect
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLabel(_ label: UILabel, inView: UIVisualEffectView) {
        label.font = .systemFont(ofSize: 25)
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.topAnchor.constraint(equalTo: inView.topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: inView.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: inView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: inView.trailingAnchor).isActive = true
    }
}
