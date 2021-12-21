//
//  DBManager.swift
//  DIARY APP
//
//  Created by sruthi on 20/12/21.
//

import UIKit

class DBManager: NSObject {
    
    static let shared = DBManager()
    
    private let DIARY_USER_DEFAULTS = "DIARY_USER_DEFAULTS"
    
    
    func saveAllDiary(diaryList: [DiaryModel]) {
        do {
            let encodedData: Data = try NSKeyedArchiver.archivedData(withRootObject: diaryList, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedData, forKey: DIARY_USER_DEFAULTS)
        } catch  {
            
        }
    }
    
    func saveDiaryById(diary: DiaryModel) {
        var arr = self.getAllDiary()
        for index in 0...arr.count {
            if arr[index].id! == diary.id {
                arr[index] = diary
                break
            }
        }
        self.saveAllDiary(diaryList: arr)

    }
    
    func getAllDiary() -> [DiaryModel] {
        
        do {
            guard let decoded  =  UserDefaults.standard.data(forKey: DIARY_USER_DEFAULTS)else {
                return []
               }
                    let decodedList = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded) as? [DiaryModel]
            
            if decodedList != nil {
                return decodedList!
            }

        } catch {
    
        }
        

        return []
            
    }
    
    
    func deleteById(_ id: String) {
        var arr = self.getAllDiary()
        for index in 0...arr.count {
            if arr[index].id! == id {
                arr.remove(at: index)
                break
            }
        }
        self.saveAllDiary(diaryList: arr)
    }
    
    func deleteAll() {
        UserDefaults.standard.removeObject(forKey: DIARY_USER_DEFAULTS)
    }
    

}
