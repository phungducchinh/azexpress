//
//  ModelContext.swift
//  AZExpress
//
//  Created by TaNhi on 6/5/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//


import Foundation

class ModelContext {
    private static var identifierCount = 1;
    private let identifier: Int;
    
    init() {
        identifier = ModelContext.identifierCount;
        ModelContext.identifierCount = ModelContext.identifierCount + 1;
    }
    
    public static func ==(lhs: ModelContext, rhs: ModelContext) -> Bool {
        return lhs.identifier == rhs.identifier;
    }
}

extension ModelContext {
    static let unspecified = ModelContext();
}

