//
//  ViewController.swift
//  TicTacToe
//
//  Created by Akshay Jangir on 30/06/21.
//  Copyright © 2021 Akshay Jangir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var state = [2,2,2,2,
                         2,2,2,2,
                         2,2,2,2,
                         2,2,2,2]
    
    private let winningCombinations = [[0, 1, 2, 3], [4, 5, 6, 7], [8, 9, 10, 11], [12, 13, 14, 15], [0, 4, 8, 12], [1, 5, 9, 13], [2, 6, 10, 14], [3, 7, 11, 15], [0, 5, 10, 15], [3, 6, 9, 12]]
    
    private var zeroFlag = false
    
    private let cv:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 81, height: 81)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    private let lbl:UILabel = {
        let labl = UILabel()
        labl.text = "1 vs 1"
        labl.textAlignment = .center
        labl.textColor = .white
        return labl
    }()
    private let btnt1: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "house"), for: .normal)
        btn.layer.borderColor = .init(srgbRed: 255, green: 255, blue: 255, alpha: 1)
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        btn.tintColor = .white
        return btn
    }()
    private let btnt2: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        btn.layer.borderColor = .init(srgbRed: 255, green: 255, blue: 255, alpha: 1)
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 8
        btn.clipsToBounds = true
        btn.tintColor = .white
        return btn
    }()
    private let hr: UIView = {
        let vu = UIView()
        vu.backgroundColor = .white
        return vu
    }()
    private let plbl1: UILabel = {
        let lbl = UILabel()
        lbl.text = "X Player 1"
        lbl.textColor = .init(red: 0, green: 0.844, blue: 0.969, alpha: 1)
        return lbl
    }()
    private let plbl2: UILabel = {
        let lbl = UILabel()
        lbl.text = "O Player 2"
        lbl.textColor = .init(red: 0.992, green: 0.260, blue: 0.957, alpha: 1)
        return lbl
    }()
    private let pslbl1: UILabel = {
        let lbl = UILabel()
        lbl.text = "0 Pts."
        lbl.textColor = .init(red: 0, green: 0.844, blue: 0.969, alpha: 1)
        return lbl
    }()
    private let pslbl2: UILabel = {
        let lbl = UILabel()
        lbl.text = "0 Pts."
        lbl.textColor = .init(red: 0.992, green: 0.260, blue: 0.957, alpha: 1)
        return lbl
    }()
    private let lbly: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.text = "X's Move"
        return lbl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addBackground()
        UILabel.appearance().font = UIFont(name: "courier", size: 20)
        view.addSubview(lbl)
        view.addSubview(btnt1)
        view.addSubview(btnt2)
        view.addSubview(hr)
        view.addSubview(plbl1)
        view.addSubview(plbl2)
        view.addSubview(pslbl1)
        view.addSubview(pslbl2)
        view.addSubview(cv)
        cv.backgroundColor = .none
        setupCollectionView()
        view.addSubview(lbly)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        lbl.frame = CGRect(x: view.width/2-40, y: 40, width: 80, height: 20)
        btnt1.frame = CGRect(x: 30, y: 40, width: 40, height: 40)
        btnt2.frame = CGRect(x: view.width-70, y: 40, width: 40, height: 40)
        hr.frame = CGRect(x: 28, y: 89, width: view.width-56, height: 1)
        plbl1.frame = CGRect(x: 30, y: 106, width: 140, height: 20)
        plbl2.frame = CGRect(x: 30, y: 136, width: 140, height: 20)
        pslbl1.frame = CGRect(x: view.width-100, y: 106, width: 80, height: 20)
        pslbl2.frame = CGRect(x: view.width-100, y: 136, width: 80, height: 20)
        cv.frame = CGRect(x: 30, y: 180, width: view.width-60, height: 400)
        lbly.frame = CGRect(x: 30, y: 590, width: view.width-60, height: 20)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    private func setupCollectionView() {
        cv.register(cells.self, forCellWithReuseIdentifier: "cells")
        cv.dataSource = self
        cv.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        16
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cells", for: indexPath) as! cells
        cell.setupCell(with: state[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if state[indexPath.row] != 0 && state[indexPath.row] != 1 {
            state.remove(at: indexPath.row)
            
            if zeroFlag {
                state.insert(0, at: indexPath.row)
                lbly.text = "X's Move"
            } else {
                state.insert(1, at: indexPath.row)
                lbly.text = "O's Move"
            }
            
            zeroFlag = !zeroFlag
            collectionView.reloadData()
            checkWinner()
        }
    }
    
    private func checkWinner() {
        
        if !state.contains(2) {
            let alert = UIAlertController(title: "Game over!", message: "Draw. Try again", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { [weak self] _ in
                self?.resetState()
            }))
            DispatchQueue.main.async {
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        for i in winningCombinations {
            if state[ i[0] ] == state[ i[1] ] && state[ i[1] ] == state[ i[2] ] && state[ i[2] ] == state[ i[3] ] && state[ i[0] ] != 2 {
                announceWinner(player: state[ i[0] ] == 0 ? "0" : "X")
                break
            }
        }
    }
    
    private func announceWinner(player: String) {
        let alert = UIAlertController(title: "Game over!", message: "\(player) won", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { [weak self] _ in
            self?.resetState()
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func resetState() {
        state = [2,2,2,2,
                 2,2,2,2,
                 2,2,2,2,
                 2,2,2,2]
        zeroFlag = false
        lbly.text = "X's Move"
        cv.reloadData()
    }
}
