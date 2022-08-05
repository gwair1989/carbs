//
//  BmrBrain.swift
//  carbs
//
//  Created by Oleksandr Khalupa on 01.08.2022.
//

import Foundation


struct BmrBrain {
    
    func getBMR(weight:Float, height:Float, age:Float, indexGender:Float, index: Float) -> [BMR] {
        var objectBMR: [BMR] = []
        
            // getting BMR to maintain weight
        let maintainResult = ((weight * 10) + (height * 6.25 ) - (age * 5) + indexGender) * index
        let maintainPFC = getPFC(objBmr: maintainResult)
        let maintain = BMR(bmr: maintainResult, protein: maintainPFC[0], fats: maintainPFC[1], carbs: maintainPFC[2])
        
        // getting BMR to losing weight
        let losingResult = maintainResult - (maintainResult * 0.2)
        let losingPFC = getPFC(objBmr: losingResult)
        let losing = BMR(bmr: losingResult, protein: losingPFC[0], fats: losingPFC[1], carbs: losingPFC[2])
        
        // getting BMR to raising weight
        let raisingResult = maintainResult + (maintainResult * 0.2)
        let raisingPFC = getPFC(objBmr: raisingResult)
        let raising = BMR(bmr: raisingResult, protein: raisingPFC[0], fats: raisingPFC[1], carbs: raisingPFC[2])
        
        objectBMR.append(losing)
        objectBMR.append(maintain)
        objectBMR.append(raising)
        
        return objectBMR
    }
    
    // get PFC by formula
   private func getPFC(objBmr: Float) -> [Float]{
        let proteinResult = objBmr * 0.3 / 4
        let fatsResult = objBmr *  0.3 / 9
        let carbsResult = objBmr * 0.4 / 4
        return [proteinResult, fatsResult, carbsResult]
    }
    
    
    // Formar Float
    func formatData(_ obj: Float) -> String {
        return String(format: "%.0f", obj)
    }
}
