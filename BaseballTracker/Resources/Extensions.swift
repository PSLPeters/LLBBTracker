//
//  Extensions.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/9/25.
//

import Foundation

// MARK: Date mm/dd/yyyy
extension Date {
        func formatDate() -> String {
                let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("MM/dd/yyyy")
            return dateFormatter.string(from: self)
        }
}

// MARK: Date Day of Week
extension Date {
        func getDayOfWeek() -> String {
                let dateFormatter = DateFormatter()
            dateFormatter.setLocalizedDateFormatFromTemplate("EEEE")
            return dateFormatter.string(from: self)
        }
}
