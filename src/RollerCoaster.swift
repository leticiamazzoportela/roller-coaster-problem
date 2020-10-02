//
//  RollerCoaster.swift
//  teste
//
//  Created by Leticia Portela on 22/09/20.
//  Copyright © 2020 Leticia Portela. All rights reserved.
//

import Foundation

class RollerCoaster {
    let totalPassengers = 5 // Number of people in the park
    let cartCapacity = 4 // Capacity of the cart
    private var availableSeats: Int = 4 // Number of available seats in the cart
    private let cartSemaphore = DispatchSemaphore(value: 4) // Semaphore to control passengers in the cart


    // Verify if the cart is full
    func cartIsFull() -> Bool {
        return self.availableSeats == 0
    }

    // If the cart not is full, the passenger gets in the car
    func passengerTriesToGetInCart(passengerId: Int) {
        if !self.cartIsFull() {
            print("The Passenger \(passengerId) gets in the cart")
            self.availableSeats -= 1
            self.cartSemaphore.wait() // The resource is required, a passenger gets in the car
        }
    }

    // Verify if the cart is running
    func cartIsRunning() -> Bool {
        if cartIsFull() {
            return true
        }

        return false
    }

    // Removes passenger of the cart and release the seats
    func passengerLeftTheCart() {
        print("The tour is over, the passengers can be released...\n")

        while self.availableSeats != self.cartCapacity {
            self.availableSeats += 1
            self.cartSemaphore.signal() // The resource can be released, a passenger can be released of the cart
        }
    }

    // Init The Roller Coaster
    func initRollerCoaster() {
        while true {
            for i in 0..<self.totalPassengers {
                // Create a thread for each passenger and each passenger tries to get in the cart
                DispatchQueue(label: "passenger-queue-\(i)", attributes: .concurrent).async {
                    self.passengerTriesToGetInCart(passengerId: i)
                }
                sleep(2)
            }

            if self.cartIsRunning() {
                print("\nThe cart is running...uiiiiii\n")
            }

            sleep(5)
            self.passengerLeftTheCart()

        }
    }
}
