//
//  BaseModel.swift
//  AZExpress
//
//  Created by TaNhi on 6/5/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import Foundation

typealias ModelDictionaryRaw = [String: Any]
typealias ModelArrayRaw = [ModelDictionaryRaw]

protocol BaseModel {
    init?(dictionary: ModelDictionaryRaw, context: ModelContext);
    func toDictionary(context: ModelContext) -> ModelDictionaryRaw?;
}

extension Array where Element: BaseModel {
    init?(array: ModelArrayRaw, context: ModelContext) {
        self.init();
        
        for item in array {
            guard let element = Element(dictionary: item, context: context) else{
                return nil;
            }
            
            append(element);
        }
    }
    
    func toArray(context: ModelContext) -> ModelArrayRaw {
        var array = ModelArrayRaw();
        for element in self {
            guard let item = element.toDictionary(context: context) else {
                continue;
            }
            
            array.append(item);
        }
        return array;
    }
}
