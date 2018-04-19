//
//  StoryboardIdentifier.swift
//  AHStoryboard
//
//  Created by Andyy Hope on 19/01/2016.
//  Copyright © 2016 Andyy Hope. All rights reserved.
//

import UIKit

public protocol StoryboardIdentifiable {
   static var storyboardIdentifier: String { get }
}

extension StoryboardIdentifiable where Self: Base_Vc {
  public  static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
