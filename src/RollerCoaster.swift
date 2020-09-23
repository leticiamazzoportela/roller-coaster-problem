//
//  RollerCoaster.swift
//
//
//  Created by Leticia Portela on 22/09/20.
//  Copyright © 2020 Leticia Portela. All rights reserved.
//

import Foundation

class RollerCoaster {
    let totalPassengers = 5
    let carCapacity = 4
    private var availableSeats: Int = 4
    private var rollerCoasterWorking: Bool = false
    private let passengerQueue = DispatchQueue(label: "passenger-queue", attributes: .concurrent)
    private let carSemaphore = DispatchSemaphore(value: 4)

    func carIsFull() -> Bool {
        return self.availableSeats == 0
    }

    func passengerTriesToGetInCar(passengerId: Int) {
//        self.passengerQueue.async {
            if !self.carIsFull() && !self.rollerCoasterWorking {
                print("The Passenger \(passengerId) gets in the car")
                self.availableSeats -= 1
                self.carSemaphore.wait()
            }
//        }
    }

    func carIsRunning() -> Bool {
        if carIsFull() {
            self.rollerCoasterWorking = true
            return true
        }

        return false
    }

    func passengerLeftTheCar() {
        self.rollerCoasterWorking = false

//        self.passengerQueue.async {
            print("\nThe tour is over, the passengers can be released...\n")

            while self.availableSeats != self.carCapacity {
                print("The passengers are getting of..")
                self.availableSeats += 1
                self.carSemaphore.signal()
            }
//        }
    }

    func initRollerCoaster() {
        while true {
            for i in 0..<self.totalPassengers {
                DispatchQueue(label: "passenger-queue-\(i)", attributes: .concurrent).async {
                    self.passengerTriesToGetInCar(passengerId: i)
                    sleep(2)
                }
            }

            if self.carIsRunning() {
                print("\nThe car is running...\n")
            }

            sleep(5)
            self.passengerLeftTheCar()

        }
    }
}
