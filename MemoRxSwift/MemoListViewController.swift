//
//  ViewController.swift
//  MemoRxSwift
//
//  Created by ㅣ on 2023/08/30.
//

import UIKit
import RxSwift
import RxCocoa

class MemoListViewController: UIViewController {

    private var memos: BehaviorRelay<[Memo]> = BehaviorRelay(value: []) //An obervable array of memos
    
    private var tableView = UITableView()
    private let disposeBag = DisposeBag() // RxSwift's tool for managing memory
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Memos"
        view.backgroundColor = .white
        
        setupTableView()
        setupAddButton()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
                
        // Use RxSwift to bind the memo data to the tableView
        memos.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, memo, cell) in
            cell.textLabel?.text = memo.content
        }
        .disposed(by: disposeBag)
    }
    
    private func setupAddButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMemo))
    }
    
    @objc private func addMemo() {
        let alertController = UIAlertController(title: "New Memo", message: "Enter your memo", preferredStyle: .alert )
        alertController.addTextField()
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] _ in
            
            //Extract the entered text and save it as a new memo
            if let content = alertController.textFields?.first?.text, !content.isEmpty {
                let newMemo = Memo(content: content)
                var currentMemos = memos.value
                currentMemos.append(newMemo)
                memos.accept(currentMemos)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}


/*
======RxSwift가 없었다면 적었어야할 코드들======
 
tableView.delegate = self
tableView.dataSource = self

extension MemoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = memos[indexPath.row].content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memo = memos[indexPath.row]
        // Handle the selected memo
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
 */



    
