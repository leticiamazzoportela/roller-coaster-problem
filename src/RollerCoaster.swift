//  RollerCoaster.swift
//
//  Created by Leticia Portela on 22/09/20.
//  Copyright © 2020 Leticia Portela. All rights reserved.
//

import Foundation

class RollerCoaster {
    var availableSeats = 4 // Number of available seats in the cart
    let cartCapacity = 4 // Capacity of the cart
    let cartSemaphore = DispatchSemaphore(value: 4) // Semaphore to control passengers in the cart
    let maxNumberOfCartRides = 2 // Max number of cart rides per day
    var totalCartRides = 0 // Total rides covered by the cart
    var passengersWaitingQueue = [Passenger]() // The queue of passengers waiting to ride in the cart

    // Verify if the cart is full
    func cartIsFull() -> Bool {
        return self.availableSeats == 0
    }

    // If the cart not is full, the passenger gets in the cart
    func passengerTriesToGetInCart(passenger: Passenger) {
        let passengerId = passenger.getPassengerId()
        let passengerIsWalking = passenger.getPassengerIsWalkingInThePark()

        if !self.cartIsFull() && !passengerIsWalking {
            print("The Passenger \(passengerId) gets in the cart")
            passenger.setPassengerCanWalkingInTheParkLater(true)

            self.availableSeats -= 1
            self.cartSemaphore.wait() // The resource is required, a passenger gets in the cart
        } else {
            print("\nThe Passenger \(passengerId) is in the waiting queue...")
            passengersWaitingQueue.append(passenger)

            print("Total of passengers waiting: \(passengersWaitingQueue.count)")
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

    // Checks if the cart can move and
    // after a while it finishes the cart ride
    func manageCartOperation() {
        if self.cartIsRunning() {
            print("\nThe cart is running...\n")
            totalCartRides += 1
        }
        
        sleep(5)
        self.passengerLeftTheCart()
    }

    // Checks if waiting queue has passengers
    // If the waiting queue has enough passengers, the cart init a new ride
    func checksWaitingQueue() {
        if passengersWaitingQueue.count >= cartCapacity {
            if totalCartRides < maxNumberOfCartRides {
                for passenger in passengersWaitingQueue {
                    passengersWaitingQueue.removeFirst()
                    
                    self.passengerTriesToGetInCart(passenger: passenger)
                    sleep(2)
                }

                manageCartOperation()   
            } else {
                print("The max number of cart rides per day is reached!!!")
                totalCartRides = 0
            }
        } else {
            print("There aren't enough passengers in the queue...\n")
        }
    }

    // Init The Roller Coaster
    func initRollerCoaster() {
        while true {
            if totalCartRides < maxNumberOfCartRides {
                totalCartRides = 0
                passengersWaitingQueue.removeAll()

                print("**** Starting The Roller Coaster ****")
                
                let totalPassengers = Int.random(in: 4...16) // Number of people in the park
                print("There are \(totalPassengers) people in the park today\n")

                for i in 0..<totalPassengers {
                    // Create a thread for each passenger and each passenger tries to get in the cart
                    DispatchQueue(label: "passenger-queue-\(i)", attributes: .concurrent).async {
                        let passenger = Passenger(passengerId: i)
                        self.passengerTriesToGetInCart(passenger: passenger)
                    }
                    sleep(2)
                }

                manageCartOperation()
                checksWaitingQueue()
                sleep(5)
            } else {
                print("The max number of cart rides per day is reached!!!")
                sleep(8)
                print("\nThe cart can be ride...\n")
                totalCartRides = 0
            }
        }
    }
}
