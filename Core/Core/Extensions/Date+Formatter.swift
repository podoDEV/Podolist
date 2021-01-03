
import Foundation

public extension Date {
  func stringYYMMDD_HHmm() -> String {
    let formatter = DateFormatter.dateFormatterOfyyMMdd_HHmm()
    return formatter.string(from: self)
  }

  func stringYYYYMMDD_HHmm() -> String {
    let formatter = DateFormatter.dateFormatterOfyyyyMMdd_HHmm()
    return formatter.string(from: self)
  }

  func stringYYYYMMDD(with join: String = ".") -> String {
    let formatter = DateFormatter.dateFormatterOfyyyyMMdd(with: join)
    return formatter.string(from: self)
  }

  func stringMMddHHmm() -> String {
    let formatter = DateFormatter.dateFormatterOfMMdd_HHmm()
    return formatter.string(from: self)
  }

  func stringMMdd(with join: String = ".") -> String {
    let formatter = DateFormatter.dateFormatterOfMMdd(with: join)
    return formatter.string(from: self)
  }

  func stringHHmm() -> String {
    let formatter = DateFormatter.dateFormatterOfHHmm()
    return formatter.string(from: self)
  }

  func stringForCalendar() -> String {
    let formatter = DateFormatter.dateFormatterOfyyyyMMddv2()
    return formatter.string(from: self)
  }

  func stringForRequest() -> String {
    let formatter = DateFormatter.dateFormatterOfyyyyMMddv2()
    return formatter.string(from: self)
  }
}

public extension DateFormatter {
  static func dateFormatterOfyyMMdd_HHmm() -> DateFormatter {
    struct Static {
      static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd HH:mm"
        formatter.calendar = Foundation.Calendar.gregorian
        return formatter
      }
    }
    return Static.dateFormatter
  }

  static func dateFormatterOfyyyyMMdd_HHmm() -> DateFormatter {
    struct Static {
      static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd HH:mm"
        formatter.calendar = Foundation.Calendar.gregorian
        return formatter
      }
    }
    return Static.dateFormatter
  }

  static func dateFormatterOfyyyyMMdd(with join: String = ".") -> DateFormatter {
    return DateFormatter().also {
      $0.dateFormat = "yyyy\(join)MM\(join)dd"
      $0.calendar = Foundation.Calendar.gregorian
    }
  }

  static func dateFormatterOfMMdd_HHmm() -> DateFormatter {
    struct Static {
      static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd HH:mm"
        formatter.calendar = Foundation.Calendar.gregorian
        return formatter
      }
    }
    return Static.dateFormatter
  }

  static func dateFormatterOfMMdd(with join: String = ".") -> DateFormatter {
    return DateFormatter().also {
      $0.dateFormat = "MM\(join)dd"
      $0.calendar = Foundation.Calendar.gregorian
    }
  }

  static func dateFormatterOfHHmm() -> DateFormatter {
    struct Static {
      static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.calendar = Foundation.Calendar.gregorian
        return formatter
      }
    }
    return Static.dateFormatter
  }

  static func dateFormatterOfyyyyMMddv2() -> DateFormatter {
    struct Static {
      static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.calendar = Foundation.Calendar.gregorian
        return formatter
      }
    }
    return Static.dateFormatter
  }
}
