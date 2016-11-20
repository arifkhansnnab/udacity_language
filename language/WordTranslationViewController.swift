//
//  WordTranslationViewController.swift
//  language
//
//  Created by Arif Khan on 11/10/16.
//  Copyright © 2016 Snnab. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class WordTranslationViewController:  UIViewController {
    
    var myTextFields = [UITextField]()
    var myButtons = [UIButton]()
    
    var sourceSentense : String = ""
    var translatedSentence : String = ""
    
    @IBOutlet weak var translatedLabel: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var sourceSentenceTextField: UITextField!
    @IBAction func checkConversion(_ sender: Any) {
        
        if ( translatedSentenceTextField.text == translatedSentence ) {
            rightLabel.isHidden = false
            wrongLabel.isHidden = true
            translatedLabel.isHidden = true
            updateMyWordStatus(word: sourceSentense, wordLearningStatus: wordLearningStatus.mastered)
        } else {
            rightLabel.isHidden = true
            wrongLabel.isHidden = false
            translatedLabel.isHidden = false
            translatedLabel.text = translatedSentence
            updateMyWordStatus(word: sourceSentense, wordLearningStatus: wordLearningStatus.unknown)
        }
    }
    @IBOutlet weak var translatedSentenceTextField: UITextField!
    @IBOutlet weak var testButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setColorsAndBorders()
        
        translatedSentenceTextField.autocorrectionType = UITextAutocorrectionType.no
        sourceSentenceTextField.text = sourceSentense
        
        wrongLabel.isHidden = true
        rightLabel.isHidden = true
        //translatedLabel.isHidden = true
        
        translatedSentence = getTranslatedWord(sourceWord: sourceSentense)!
    }
    
    func updateMyWordStatus(word: String, wordLearningStatus: String?) {
        
        
        let context = CoreDataStackManager.sharedInstance().managedObjectContext!
        let userWords = NSFetchRequest<UserWords>(entityName: "UserWords")
        let searchQuery = NSPredicate(format: "loginId = %@ AND word = %@", argumentArray: [UserManager.GetLogedInUser(), word])
        userWords.predicate = searchQuery
        
        if let result = try? context.fetch(userWords) {
            for object in result {
                (object as UserWords).learningStatus = wordLearningStatus
            }
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print (error)
        }
        
    }
    
    func setColorsAndBorders() {
        myTextFields = [sourceSentenceTextField,translatedSentenceTextField]
        myButtons = [testButton]
        
        for item in myTextFields {
            item.setPreferences()
        }
        
        for item in myButtons {
            item.setPreferences()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTranslatedWord(sourceWord : String) -> String? {
        let context = CoreDataStackManager.sharedInstance().managedObjectContext!
        let words = NSFetchRequest<Words>(entityName: "Word")
        
        
        let searchQuery = NSPredicate(format: "sourceWord = %@", argumentArray: [sourceWord])
        words.predicate = searchQuery
        
        
        if let result = try? context.fetch(words) {
            for object in result {
                    return (object as Words).convertedRomanWord
            }
        }
        return nil
    }
}



