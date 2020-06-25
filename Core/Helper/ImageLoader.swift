//
//  ImageLoader.swift
//  Podolist
//
//  Created by hb1love on 2019/11/27.
//  Copyright © 2019 podo. All rights reserved.
//

import UIKit

public class ImageLoader {
  private static let cache = NSCache<NSString, NSData>()
  
  public class func image(for urlString: String?, completion: @escaping (_ image: UIImage?) -> ()) {
    guard let urlString = urlString, let url = URL(string: urlString) else {
      completion(nil)
      return
    }
    image(for: url, completion: completion)
  }
  
  public class func image(for url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
    DispatchQueue.global(qos: DispatchQoS.QoSClass.background).async {
      if let data = self.cache.object(forKey: url.absoluteString as NSString) {
        DispatchQueue.main.async { completion(UIImage(data: data as Data)) }
        return
      }
      
      guard let data = NSData(contentsOf: url) else {
        DispatchQueue.main.async { completion(nil) }
        return
      }
      
      self.cache.setObject(data, forKey: url.absoluteString as NSString)
      DispatchQueue.main.async { completion(UIImage(data: data as Data)) }
    }
  }
}
