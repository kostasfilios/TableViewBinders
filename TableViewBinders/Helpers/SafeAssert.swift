//
//  SafeAssert.swift
//  TableViewBinders
//
//  Created by Kostas Filios on 25/7/22.
//


import Foundation

func safeAssert() {
    #if DEBUG
    raise(SIGINT)
    #endif
}
