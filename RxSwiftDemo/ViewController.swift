//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by MB on 8/12/19.
//  Copyright © 2019 MB. All rights reserved.
//https://docs.google.com/document/d/1OX74WwYKqfFbtkHlgJsMAxidtLnSI8HAxu3rCIIxGgY/edit?usp=sharing
//https://docs.google.com/document/d/19m1YxKO86SSpqOJEoEb9pWrUZQr5MboCKyJqxNmZMXc/edit?usp=sharing

import UIKit
import RxSwift
class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        normalSwift()
        
        reactiveSwiftEg3()
    }

    func normalSwift(){
        var userBalance = 5
        let productprice = 10
        
        let canMakePurchase = userBalance >= productprice
        print(canMakePurchase)  //false
        
        userBalance += 20
        print(canMakePurchase) //still false
        
        print("**********************************")
    }
    
    //old method of declaring observable with Varriable
    func reactiveSwiftEg1(){
        var userBalance  = Variable<Int>(5)
        let productprice = Variable<Int>(10)
        
        let canMakePurchase = Observable.combineLatest(userBalance.asObservable(),productprice.asObservable()).map{$0 >= $1}
        
        print(canMakePurchase)
        
        userBalance = Variable<Int>(20)
        
        print(canMakePurchase)
        
        print("**********************************")
    }
    
    //New method of declarring Observable which is a sequeence of elemtents
    func reactiveSwiftEg2(){
        var userBalance  = Observable.of(5)
        let productprice = Observable.of(10)
        
        let canMakePurchase = Observable.combineLatest(userBalance,productprice).map{$0 >= $1}
        
        print(canMakePurchase)
        
        userBalance = Observable.of(20)
        
        print(canMakePurchase)
        
        print("**********************************")
    }
    
    
    //subscribing
    //DisposeBag is disposing memory consumed by subscriber
    func reactiveSwiftEg3(){

        let numbers = Observable.of(1,4,-24,400)
        
        numbers.subscribe(
            onNext: { (value) in
            print("Got next Value \(value)")
        },
            onError: { (error) in
                print("An error occurred \(error)")
        },
            onCompleted: {
                print("Completed")
        },
            onDisposed: {
                print("Disposed")
        })
        .disposed(by: disposeBag)
        
        print("**********************************")
    }
    



}

