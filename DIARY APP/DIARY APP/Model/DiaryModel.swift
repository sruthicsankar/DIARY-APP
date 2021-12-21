//
//  DiaryModel.swift
//  DIARY APP
//
//  Created by sruthi on 20/12/21.
//

import Foundation
 

public class DiaryModel: NSObject, NSCoding {
    public func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(title, forKey: "title")
        coder.encode(content, forKey: "content")
        coder.encode(date, forKey: "date")


    }
    
    public required init?(coder: NSCoder) {
        id = coder.decodeObject(forKey: "id") as? String
        title = coder.decodeObject(forKey: "title") as? String
        content = coder.decodeObject(forKey: "content") as? String
        date = coder.decodeObject(forKey: "date") as? String

    }
    
	public var id : String?
	public var title : String?
	public var content : String?
	public var date : String?

    private let DATE_FORMATTER = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"

    public class func modelsFromDictionaryArray(array:NSArray) -> [DiaryModel]
    {
        var models:[DiaryModel] = []
        for item in array
        {
            models.append(DiaryModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }


	required public init?(dictionary: NSDictionary) {

		id = dictionary["id"] as? String
		title = dictionary["title"] as? String
		content = dictionary["content"] as? String
		date = dictionary["date"] as? String
	}


	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.id, forKey: "id")
		dictionary.setValue(self.title, forKey: "title")
		dictionary.setValue(self.content, forKey: "content")
		dictionary.setValue(self.date, forKey: "date")

		return dictionary
	}

    
    func getMonth(previousDiary: DiaryModel?) -> String {
        
        if let d = self.date {
            
            let Dateformatter = DateFormatter()
            Dateformatter.dateFormat = DATE_FORMATTER
            let date1 = Dateformatter.date(from: d)
            
            Dateformatter.dateFormat  = "MMM"
            let strMonth = Dateformatter.string(from: date1!)
            
            if previousDiary != nil {
                
                Dateformatter.dateFormat = DATE_FORMATTER
                let preDate = Dateformatter.date(from: previousDiary!.date ?? "")
                
                Dateformatter.dateFormat  = "MMM"
                let strPreMonth = Dateformatter.string(from: preDate!)
                
                if strMonth.uppercased() == strPreMonth.uppercased() {
                    return "="
                }
            }
            
            return strMonth.uppercased()
        }
        
        return "-"
        
    }
    
    func getTime() -> String {
        if let d = self.date {
            let Dateformatter = DateFormatter()
            Dateformatter.dateFormat = DATE_FORMATTER
            
            let date1 = Dateformatter.date(from: d)
            
            
            
            let distanceBetweenDates: TimeInterval? = Date().timeIntervalSince(date1!)
            let secondsInAnHour: Double = 3600
            let secondsInDays: Double = 86400
            let secondsInWeek: Double = 604800
            let secondsInYear: Double = 60*60*24*365

            let hoursBetweenDates = Int((distanceBetweenDates! / secondsInAnHour))
            let daysBetweenDates = Int((distanceBetweenDates! / secondsInDays))
            let weekBetweenDates = Int((distanceBetweenDates! / secondsInWeek))
            let yearBetwweDares = Int((distanceBetweenDates! / secondsInYear))

            
            if yearBetwweDares > 0 {
                return "\(yearBetwweDares) years ago"
            }
            else if weekBetweenDates > 0 {
                return "\(weekBetweenDates) weeks ago"
            }
            else if daysBetweenDates > 0 {
                return "\(daysBetweenDates) days ago"
            }
            else  {
                return "\(hoursBetweenDates) hours ago"
            }
            
            
        }
        
        return "Now"
    }
    
    
}
