//
//  MonthConverter.swift
//  WSB
//
//  Created by apple on 21.04.2018.
//  Copyright © 2018 devant. All rights reserved.
//

import Foundation
// MONTH NUMBER TO NAME CONVERTER
class MonthConverter {
    
    // MARK: ENGLISH
    static func monthName(month: Int, language: String) -> String {
        var monthName: String = ""
        if language == "pl" {
            monthName = polishMonthName(month: month)
        }
        if language == "ru" {
            monthName = russianMonthName(month: month)
        }
        else if language == "en" {
            monthName = englishMonthName(month: month)
        }
        return monthName
    }
    // MARK: ENGLISH
    static func englishMonthName(month: Int) -> String {
        switch month {
        case 1:
            return "Jan."
        case 2:
            return "Feb."
        case 3:
            return "Mar."
        case 4:
            return "Apr."
        case 5:
            return "May"
        case 6:
            return "June"
        case 7:
            return "July"
        case 8:
            return "Aug."
        case 9:
            return "Sept."
        case 10:
            return "Oct."
        case 11:
            return "Nov."
        case 12:
            return "Dec."
        default:
            return "Error"
        }
    }
    // MARK: POLISH
    static func polishMonthName(month: Int) -> String {
        switch month {
        case 1:
            return "Sty."
        case 2:
            return "Lut."
        case 3:
            return "Mar."
        case 4:
            return "Kwi."
        case 5:
            return "Maj"
        case 6:
            return "Cze."
        case 7:
            return "Lip."
        case 8:
            return "Sie."
        case 9:
            return "Wrz."
        case 10:
            return "Paź."
        case 11:
            return "Lis."
        case 12:
            return "Gru."
        default:
            return "Error"
        }
    }
    // MARK: RUSSIAN
    static func russianMonthName(month: Int) -> String {
        switch month {
        case 1:
            return "янв."
        case 2:
            return "февр."
        case 3:
            return "март"
        case 4:
            return "апр."
        case 5:
            return "май"
        case 6:
            return "июнь"
        case 7:
            return "июль"
        case 8:
            return "авг."
        case 9:
            return "сент."
        case 10:
            return "окт."
        case 11:
            return "ноябрь"
        case 12:
            return "дек."
        default:
            return "Error"
        }
    }
}
