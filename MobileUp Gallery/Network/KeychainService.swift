//
//  KeychainService.swift
//  MobileUp Gallery
//
//  Created by Михаил on 31.03.2022.
//

import Foundation

enum Service: String {
    case vk
}

class KeychainService {
    
    func updatePassword(_ password: String, serviceKey: Service) {
        guard let dataFromString = password.data(using: .utf8) else { return }
        
        let keychainQuery: [CFString : Any] = [kSecClass: kSecClassGenericPassword,
                                               kSecAttrService: serviceKey.rawValue,
                                               kSecValueData: dataFromString]
        SecItemDelete(keychainQuery as CFDictionary)
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    
    func removePassword(serviceKey: Service) {
        
        let keychainQuery: [CFString : Any] = [kSecClass: kSecClassGenericPassword,
                                               kSecAttrService: serviceKey.rawValue]
        
        SecItemDelete(keychainQuery as CFDictionary)
    }
    
    func loadPassword(serviceKey: Service) -> String? {
        let keychainQuery: [CFString : Any] = [kSecClass : kSecClassGenericPassword,
                                               kSecAttrService : serviceKey.rawValue,
                                               kSecReturnData: kCFBooleanTrue ?? true,
                                               kSecMatchLimitOne: kSecMatchLimitOne]
        
        var dataTypeRef: AnyObject?
        SecItemCopyMatching(keychainQuery as CFDictionary, &dataTypeRef)
        guard let retrievedData = dataTypeRef as? Data else { return nil }
        
        return String(data: retrievedData, encoding: .utf8)
    }
    
    func flush()  {
        let secItemClasses =  [kSecClassGenericPassword]
        for itemClass in secItemClasses {
            let spec: NSDictionary = [kSecClass: itemClass]
            SecItemDelete(spec)
        }
    }
}
