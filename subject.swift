//: Playground - noun: a place where people can play

import UIKit


//let url = Bundle.main.url(forResource: "students", withExtension: "json")
//print(url)

let studentsName = ["jake", "jain", "hana", "john", "steve", "bill"]

var jake_grade = ["data_structure": 85,"algorithm": 76, "database": 42, "operating_system": 83]
var jain_grade = ["data_structure": 56,"algorithm": 65, "networking": 68, "database": 46, "operating_system": 83]
var hana_grade = ["data_structur": 86, "algorithm": 64, "database": 87, "operating_system": 96]
var john_grade = ["data_structure": 35, "networking": 45, "database": 78]
var steve_grade = ["algorithm": 56, "networking": 89, "operating_system": 100]
var bill_grade = ["data_structure": 87,"algorithm": 45, "database": 65, "operating_system": 78]


var student: [Dictionary<String, String>] = []
var studentInfo: [String : String] = [:]

func calculateSum(grade: Dictionary<String, Int>) -> [Int]{
    var sum = 0
    var count = 0
    let scores = [Int](grade.values)
    count = scores.count
    for sco in scores{
        sum = sum + sco
    }
    let arr: [Int] = [sum,count]
    return arr
}

var sumTA:Double = 0
var scoresTA: [Int] = []
var averageTA: Double = 0;
var numTA = 0;
func TotalAverage(grade: Dictionary<String, Int>) -> Double{
    numTA = numTA + 1

    scoresTA = [Int](grade.values)
    let count = scoresTA.count
    var average: Double = 0
    var sum = 0
    
    for sco in scoresTA{
        sum = sum + sco
    }
    average = Double(sum)/Double(count)
    sumTA = sumTA + average
    
    averageTA = Double(sumTA)/Double(numTA)
    return averageTA
}

func calculateAverage(arr: [Int]) -> Double{
    let sum = arr[0]
    let count = arr[1]
    var average: Double = 0
    average = Double(sum)/Double(count)
    return average
}

func calculateGrade(average: Double) -> String{
    var grade = "unkown"
    
    if average >= 90 {
      grade = "A"
    } else if average >= 80 {
        grade = "B"
    } else if average >= 70 {
        grade = "C"
    }else if average >= 60 {
        grade = "D"
    }else {
        grade = "F"
    }
    return grade
}



studentInfo["name"] = studentsName[0]
studentInfo["score"] = calculateGrade(average: calculateAverage(arr: calculateSum(grade: jake_grade)))
student.append(studentInfo)

studentInfo["name"] = studentsName[1]
studentInfo["score"] = calculateGrade(average: calculateAverage(arr: calculateSum(grade: jain_grade)))
student.append(studentInfo)

studentInfo["name"] = studentsName[2]
studentInfo["score"] = calculateGrade(average: calculateAverage(arr: calculateSum(grade: hana_grade)))
student.append(studentInfo)

studentInfo["name"] = studentsName[3]
studentInfo["score"] = calculateGrade(average: calculateAverage(arr: calculateSum(grade: john_grade)))
student.append(studentInfo)

studentInfo["name"] = studentsName[4]
studentInfo["score"] = calculateGrade(average: calculateAverage(arr: calculateSum(grade: steve_grade)))
student.append(studentInfo)

studentInfo["name"] = studentsName[5]
studentInfo["score"] = calculateGrade(average: calculateAverage(arr: calculateSum(grade: bill_grade)))
student.append(studentInfo)


let sortedStudent = student.sorted(by: {
    return $0["name"]! < $1["name"]!
})
///내림차순 정렬

TotalAverage(grade: jake_grade)
TotalAverage(grade: jain_grade)
TotalAverage(grade: hana_grade)
TotalAverage(grade: john_grade)
TotalAverage(grade: steve_grade)

var contents: String = ""


print("성적결과표\n")
let totalAve = String(format: "%.2f", TotalAverage(grade: bill_grade))
print("전체 평균 : \(totalAve)\n")


contents.append("성적결과표\n\n")
contents.append("전체 평균 : \(totalAve)\n\n")
contents.append("개인별 학점\n")

print("개인별 학점")

var successStudent: [String] = []
for score in sortedStudent{
    print(score["name"]!, " \t: ", score["score"]!)
    contents.append("\(score["name"]!) \t: \(score["score"]!)\n")
    if score["score"]! == "A"{
        successStudent.append(score["name"]!)
    } else if score["score"]! == "B"{
        successStudent.append(score["name"]!)
    } else if score["score"]! == "C"{
        successStudent.append(score["name"]!)
    } else {
        
    }
}


print("\n수료생 \r")
var c = 0;
var s = ""
while c < successStudent.count {
    s.append(successStudent[c])
    if c < 2 {
        s.append(", ")
    }
    c = c + 1
}
print(s)


contents.append("\n수료생\n\(s)")


extension String {
    func appendLineToURL(fileURL: URL) throws {
        try (contents + "\n").appendToURL(fileURL: fileURL)
    }
    
    func appendToURL(fileURL: URL) throws {
        let data = self.data(using: String.Encoding.utf8)!
        try data.append(fileURL: fileURL)
    }
}

extension Data {
    func append(fileURL: URL) throws {
        if let fileHandle = FileHandle(forWritingAtPath: fileURL.path) {
            defer {
                fileHandle.closeFile()
            }
            fileHandle.seekToEndOfFile()
            fileHandle.write(self)
        }
        else {
            try write(to: fileURL, options: .atomic)
        }
    }
}
//test
do {
    let dir: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last! as URL
    let url = dir.appendingPathComponent("result.txt")
    try "Test \(Date())".appendLineToURL(fileURL: url as URL)
    let result = try String(contentsOf: url as URL, encoding: String.Encoding.utf8)
}
catch {
    print("Could not write to file")
}
