//
//  ViewController.swift
//  DIARY APP
//
//  Created by sruthi on 20/12/21.
//

import UIKit

class HomeController: UIViewController {

    @IBOutlet weak var tblVw: UITableView!

    var arrDiaryMode : [DiaryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.title = "My Diary"
        self.tblVw.register(UINib.init(nibName: "DiaryCell", bundle: nil), forCellReuseIdentifier: "DiaryCell")
        self.tblVw.delegate = self
        self.tblVw.dataSource = self
        
        
        self.getDiaryList()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showUpdatedList()
    }
    

    func showUpdatedList() {
        
        
        self.arrDiaryMode.removeAll()
        self.arrDiaryMode = DBManager.shared.getAllDiary()
        self.tblVw.reloadData()
        
        
        
    }
    
    func getDiaryList()
    {
        let url = URL(string: "https://private-ba0842-gary23.apiary-mock.com/notes")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            DispatchQueue.main.async {
                if error != nil {
                    self.showError(title: "Network error", msg: "Unable to contact the server")
                }
                else {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray {
                            let arr = DiaryModel.modelsFromDictionaryArray(array: json)
                            
                            DBManager.shared.saveAllDiary(diaryList: arr)
                            
                            
                        }
                        else {
                            self.showError(title: "Network error", msg: "Unable to contact the server")
                        }
                    } catch let error as NSError {
                        self.showError(title: "Network error", msg: "Unable to contact the server")
                    }
                }
                
                self.showUpdatedList()
            }
            
            
        }
        task.resume()
    }
    
    
    func showError(title: String, msg: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
                 self.navigationController?.popViewController(animated: true)
             }))
             present(alert, animated: true)
    }
    
    
    @IBAction func onClickEdit(_ sender: UIButton) {
        
        let diary = self.arrDiaryMode[sender.tag]
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "EditViewController") as! EditViewController
        controller.diary = diary
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    
    @IBAction func onClickDelete(_ sender: UIButton) {
        
        let diary = self.arrDiaryMode[sender.tag]
        DBManager.shared.deleteById(diary.id!)
        
        self.showUpdatedList()
    }
    

}

extension HomeController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrDiaryMode.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "DiaryCell", for: indexPath) as! DiaryCell
        
        cell.addShadow()
        let diary = self.arrDiaryMode[indexPath.row]
        cell.assignDiaryModel(diary)
        
        var preDiary: DiaryModel? = nil
        if indexPath.row > 0 {
            preDiary = self.arrDiaryMode[indexPath.row-1]
        }
        let mon = diary.getMonth(previousDiary: preDiary)
        if mon == "=" {
            cell.lblTime1.text = ""
            cell.vwTimeTop.isHidden = true
        }
        else {
            cell.lblTime1.text = mon
            cell.vwTimeTop.isHidden = false
        }
        
        cell.btnEdit.tag = indexPath.row
        cell.btnDelete.tag = indexPath.row
        
        cell.btnEdit.addTarget(self, action: #selector(onClickEdit(_:)), for: .touchUpInside)
        cell.btnDelete.addTarget(self, action: #selector(onClickDelete(_:)), for: .touchUpInside)

        return cell
    }
    
    
}

