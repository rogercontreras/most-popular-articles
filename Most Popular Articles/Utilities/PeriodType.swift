//
//  PeriodType.swift
//  Most Popular Articles
//
//  Created by Rogelio Contreras on 06/12/24.
//


enum PeriodType: Int, CaseIterable {
	case day = 1
	case week = 7
	case month = 30
	
	func toString() -> String {
		switch self {
			case .day:
				return "Day"
			case .week:
				return "Week"
			case .month:
				return "Month"
		}
	}
}