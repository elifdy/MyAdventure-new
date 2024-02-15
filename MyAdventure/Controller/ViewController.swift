//
//  ViewController.swift
//  MyAdventure
//
//  Created by Elif Dede on 2/14/24.
//

import UIKit


class ViewController: UIViewController {

    
    @IBOutlet weak var statementText: UILabel!
    
    @IBOutlet weak var buttonOne: UIButton!
    

    @IBOutlet weak var buttonTwo: UIButton!
    
    @IBOutlet weak var buttonRestart: UIButton!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    var recipeLogic = RecipeSelectionLogic()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func buttonClick(_ sender: UIButton) {
        guard let selectedOption = sender.titleLabel?.text else { return }
        recipeLogic.selectOption(selectedOption)
        
        if recipeLogic.layerIndex <= 2{
            updateUI()
        } else
        if let recipeImageName = recipeLogic.getFinalRecipeImageName() {
            backgroundImage.image = UIImage(named: recipeImageName)
            buttonOne.isHidden = true
            buttonTwo.isHidden = true
            buttonRestart.isHidden = false
         
            if let finalRecipe = recipeLogic.getFinalRecipe() {
                statementText.text = "Enjoy your \(finalRecipe)!"
            }
        }
    }

    
    @IBAction func restartButtonClick(_ sender: Any) {
        recipeLogic.restart()
        updateUI()
        
       
        buttonOne.isHidden = false
        buttonTwo.isHidden = false
        buttonRestart.isHidden = true

        backgroundImage.image = nil
    }

    @objc func updateUI() {
       
        statementText.text = recipeLogic.getNextQuestion()
        let options = recipeLogic.getOptions()
        let buttonFont = UIFont(name: "Futura-Bold", size: 36)
        if options.indices.contains(0) {
                let attributedTitleOne = NSAttributedString(string: options[0], attributes: [.font: buttonFont as Any])
                buttonOne.setAttributedTitle(attributedTitleOne, for: .normal)
            }
        if options.indices.contains(1) {
               let attributedTitleTwo = NSAttributedString(string: options[1], attributes: [.font: buttonFont as Any])
               buttonTwo.setAttributedTitle(attributedTitleTwo, for: .normal)
           }
            
            
        buttonOne.setTitle(options[0], for: .normal)
        buttonTwo.setTitle(options.count > 1 ? options[1] : "", for: .normal)
        buttonRestart.titleLabel?.font = UIFont(name: "Futura-Bold", size: 36)
        buttonRestart.isHidden = true

}
    
}

