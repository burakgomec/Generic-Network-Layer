//
//  HTTPConstants.swift
//
//
//  Created by Burak Gomec on 16.12.2023.
//

public enum HTTPConstants {
    public enum Methods: String {
        case GET
        case POST
        case PUT
        case DELETE
        case PATCH
    }
    
    public enum AllContentTypes: String {
        case json = "application/json"
        case xml = "application/xml"
        case form = "application/x-www-form-urlencoded"
        case formData = "multipart/form-data"
        case plainText = "text/plain"
    }
    
    public enum EncodableContentTypes: String {
        case json = "application/json"
        case formURLEncoded = "application/x-www-form-urlencoded"
        case plainText = "text/plain"
    }
}
