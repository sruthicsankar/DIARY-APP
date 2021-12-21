//
//  EditViewController.swift
//  DIARY APP
//
//  Created by sruthi on 20/12/21.
//

import UIKit

class EditViewController: UIViewController {
    var diary: DiaryModel? = nil

    @IBOutlet weak var tvDiaryContent: UITextView!
    @IBOutlet weak var txtDiaryTitle: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.txtDiaryTitle.delegate = self
        self.tvDiaryContent.delegate = self
        
        self.txtDiaryTitle.text = self.diary?.title ?? ""
        self.tvDiaryContent.text = self.diary?.content ?? ""

        self.navigationItem.title =  self.txtDiaryTitle.text
        self.navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onClickSave(_ sender: Any) {
        
        self.view.endEditing(true)
        
        self.diary!.title = self.txtDiaryTitle.text
        self.diary!.content = self.tvDiaryContent.text
        
        DBManager.shared.saveDiaryById(diary: self.diary!)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func tapDone() {
        self.view.endEditing(true)
    }
    
    
}

extension EditViewController: UITextViewDelegate, UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}



