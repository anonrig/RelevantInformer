//
//  ViewController.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 16.07.2020.
//  Copyright © 2020 Relevant Fruit. All rights reserved.
//

import UIKit
import RelevantInformer

final class ViewController: UIViewController {
  
  private var count: Int = 0
  
  private lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumInteritemSpacing = Constants.interItemSpaing
    layout.minimumLineSpacing = Constants.interItemSpaing
    
    let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
    view.backgroundColor = .white
    view.alwaysBounceVertical = true
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(collectionView)
    collectionView.fillSuperview()

    collectionView.register(PresetCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.reloadData()
  }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return Presets.allCases.count
  }
 
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell",
                                                  for: indexPath) as! PresetCollectionViewCell
    let item = Presets.allCases[indexPath.item]
    cell.backgroundColor = .red
    cell.configure(with: item.rawValue)
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let item = Presets.allCases[indexPath.item]
    item.action(count: count)
    count += 1
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    
    let width = (view.frame.size.width - Constants.margin * 2) / 2 - Constants.interItemSpaing
    return CGSize(width: width, height: width)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: Constants.margin, bottom: 0, right: Constants.margin )
  }
}

private extension ViewController {
  
  struct Constants {
    static let margin: CGFloat = 16
    static let interItemSpaing: CGFloat = 10
  }
}

enum Presets: String, CaseIterable {
  case popup
  case overridingPopup
  case notification
  case bottomBar
  case popupDissmisses
  case overrideAndRemoveAll
  
  func action(count: Int = 0) {
    switch self {
    case .popup:
      let controller = ExampleViewController()
      controller.descriptionLabel.text = "\(count)"
      var attributes = RIAttributes.popup
      attributes.displayDuration = .infinity
      attributes.interaction.onScreen = .forwardToLowerWindow
      controller.ri.display(with: attributes)
      
    case .overridingPopup:
      let controller = ExampleViewController()
      controller.descriptionLabel.text = "\(count)"
      var attributes = RIAttributes.popup
      attributes.displayDuration = .infinity
      attributes.interaction.onScreen = .forwardToLowerWindow
      controller.ri.display(with: attributes, displayMethod: .override(removeRest: false))
      
    case .notification:
      let controller = NotificationExampleViewController()
      var attributes = RIAttributes.notification
      attributes.interaction.onScreen = .forwardToLowerWindow
      controller.ri.display(with: attributes)
    
    case .popupDissmisses:
      let controller = ExampleViewController()
      controller.descriptionLabel.text = "\(count)"
      var attributes = RIAttributes.popup
      attributes.displayDuration = .infinity
      attributes.interaction.onScreen = .forwardToLowerWindow
      controller.ri.display(with: attributes)
      after(seconds: 2) {
        controller.ri.dismiss()
      }
      
    case .overrideAndRemoveAll:
      let controller = ExampleViewController()
      controller.descriptionLabel.text = "\(count)"
      var attributes = RIAttributes.popup
      attributes.displayDuration = .infinity
      attributes.interaction.onScreen = .forwardToLowerWindow
      controller.ri.display(with: attributes, displayMethod: .override(removeRest: true))
      
    case .bottomBar:
      let controller = NotificationExampleViewController()
      var attributes = RIAttributes.solidBottomBar
      attributes.interaction.onScreen = .forwardToLowerWindow
      controller.ri.display(with: attributes)
      
    default:
      break
    }
  }
}
