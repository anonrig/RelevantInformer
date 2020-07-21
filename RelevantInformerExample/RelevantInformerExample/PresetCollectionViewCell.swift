//
//  PresetCollectionViewCell.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 21.07.2020.
//  Copyright © 2020 Relevant Fruit. All rights reserved.
//

import UIKit

final class PresetCollectionViewCell: UICollectionViewCell {
  
  private let textLabel = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    addSubview(textLabel)
    textLabel.anchorCenterSuperview()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

extension PresetCollectionViewCell {
  
  func configure(with display: String) {
    textLabel.text = display
  }
}
