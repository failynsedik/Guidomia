//
//  JSONParser.swift
//  Guidomia
//
//  Created by Failyn Kaye Sedik on 1/27/22.
//

import Foundation

public enum JSONParser {
	/// Parses a `.json` file into a specified data type.
    public static func parse<T: Decodable>(resource: String, intoType _: T.Type) -> T? {
        guard let path = Bundle.main.path(forResource: resource, ofType: "json") else {
            return nil
        }

        let url = URL(fileURLWithPath: path)

        do {
            let data = try Data(contentsOf: url)
            let result = try JSONDecoder().decode(T.self, from: data)
            return result
        } catch {
            #if DEBUG
                print(error)
            #endif

            return nil
        }
    }
}
