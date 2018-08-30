//
//  FilterViewControllerV2.swift
//  Truth
//
//  Created by David Celentano on 8/30/18.
//  Copyright © 2018 David Celentano. All rights reserved.
//

import UIKit
import SnapKit

enum Stats {
    case subclass
    case primary
    case special
    case heavy
    case lightLevel
    case overallKD
    case overallKDA
    case overallWinLoss
    case overallCombatRating
    case timePlayed
}

class FilterViewControllerV2: UIViewController {
    
    private var dismissButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle("Done", for: .normal)
        b.layer.cornerRadius = 5
        b.layer.borderWidth = 1
        b.layer.borderColor = UIColor.white.cgColor
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        b.tintColor = .white
        b.addTarget(self, action: #selector(dismissTapped), for: .touchUpInside)
        return b
    }()
    
    fileprivate let tableView = UITableView(frame: CGRect.zero, style: .plain) // think about making this grouped when more stats are added
    fileprivate let statCellIdentifier = "StatCell"
    fileprivate let statsArray = [Stats.subclass, Stats.primary, Stats.special, Stats.heavy, Stats.lightLevel, Stats.overallKD, Stats.overallKDA, Stats.overallWinLoss, Stats.overallCombatRating, Stats.timePlayed]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(StatCell.self, forCellReuseIdentifier: statCellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .black
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        setUpGradient()
        
        view.addSubview(dismissButton)
        dismissButton.snp.makeConstraints { make in
            make.top.equalTo(view).offset(15)
            make.leading.equalTo(view).offset(15)
            make.width.equalTo(60)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(dismissButton.snp.bottom).offset(15)
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
    }
    
    // creates a gradient for the view background
    private func setUpGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        view.backgroundColor = UIColor.truthBlue
        gradientLayer.colors = [UIColor.truthBlue.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0, 1.0]
        view.layer.sublayers?.insert(gradientLayer, at: 0)
    }
    
    @objc private func dismissTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension FilterViewControllerV2: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = StatCell(style: .default, reuseIdentifier: statCellIdentifier)
        switch statsArray[indexPath.row] {
        case Stats.subclass:
            cell.statLabel.text = "Class | Subclass: (Destiny 1 only shows subclass)"
            cell.statSwitch.setOn(UserDefaults.standard.value(forKey: "subclassEnabled") as? Bool ?? true, animated: true)
        case Stats.primary:
            cell.statLabel.text = "Primary Weapon"
            cell.statSwitch.setOn(UserDefaults.standard.value(forKey: "primaryEnabled") as? Bool ?? true, animated: true)
        case Stats.special:
            cell.statLabel.text = "Special Weapon"
            cell.statSwitch.setOn(UserDefaults.standard.value(forKey: "specialEnabled") as? Bool ?? true, animated: true)
        case Stats.heavy:
            cell.statLabel.text = "Heavy Weapon"
            cell.statSwitch.setOn(UserDefaults.standard.value(forKey: "heavyEnabled") as? Bool ?? true, animated: true)
        case Stats.lightLevel:
            cell.statLabel.text = "Light Level"
            cell.statSwitch.setOn(UserDefaults.standard.value(forKey: "lightLevelEnabled") as? Bool ?? true, animated: true)
        case Stats.overallKD:
            cell.statLabel.text = "Overall KD: Kills / Deaths ratio for all characters"
            cell.statSwitch.setOn(UserDefaults.standard.value(forKey: "overallKDEnabled") as? Bool ?? true, animated: true)
        case Stats.overallKDA:
            cell.statLabel.text = "Overall KDA: Kills + [Assists / 2] / Deaths ratio for all characters"
            cell.statSwitch.setOn(UserDefaults.standard.value(forKey: "overallKDAEnabled") as? Bool ?? true, animated: true)
        case Stats.overallWinLoss:
            cell.statLabel.text = "Overall Win/Loss: Wins / Losses ratio for all characters"
            cell.statSwitch.setOn(UserDefaults.standard.value(forKey: "overallWinLossEnabled") as? Bool ?? true, animated: true)
        case Stats.overallCombatRating:
            cell.statLabel.text = "Overall Combat Rating: An assessment of your skill and teamwork. It factors in your score compared to others in each match and penalizes you for quitting."
            cell.statSwitch.setOn(UserDefaults.standard.value(forKey: "overallCombatRatingEnabled") as? Bool ?? true, animated: true)
        case Stats.timePlayed:
            cell.statLabel.text = "Hours played on current character"
            cell.statSwitch.setOn(UserDefaults.standard.value(forKey: "timePlayedEnabled") as? Bool ?? true, animated: true)
        }
        return cell
    }
    
    
}
