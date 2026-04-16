//
//  AnalyticsProtocol.swift
//  MovieDB
//
//  Created by Maria Eduarda on 16/04/26.
//

import Foundation


protocol AnalyticsProtocol {
    func track(event: AnalyticsEvent)
}
