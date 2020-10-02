//
//  RollerCoaster.swift
//  teste
//
//  Created by Leticia Portela on 22/09/20.
//  Copyright © 2020 Leticia Portela. All rights reserved.
//

import Foundation

class Cart {
    let carCapacity = 4
    private var availableSeats: Int = 4
    private let carSemaphore = DispatchSemaphore(value: 4)
    var totalPassengers: Int
    var carId: String

    init(totalPassengers: Int, carId: String) {
        self.totalPassengers = totalPassengers
        self.carId = carId
    }

    func carIsFull() -> Bool {
        return self.availableSeats == 0
    }

    func passengerTriesToGetInCar(passengerId: Int) {
        if !self.carIsFull() {
            print("The Passenger \(passengerId) gets in the car \(self.carId)")
            self.availableSeats -= 1
            self.carSemaphore.wait()
        }
    }

    func carIsRunning() -> Bool {
        if carIsFull() {
            return true
        }

        return false
    }

    func passengerLeftTheCar() {
        print("\nThe tour is over, the passengers can be released of the car \(self.carId)...\n")

        while self.availableSeats != self.carCapacity {
            self.availableSeats += 1
            self.carSemaphore.signal()
        }
    }
}

class RollerCoaster {
    var totalCarts: Int
    private var rollerCoasterWorking: Bool = false
    var totalPassengers: Int

    init(totalPassengers: Int, totalCarts: Int) {
        self.totalPassengers = totalPassengers
        self.totalCarts = totalCarts
    }

    func initRollerCoaster() {
        var carts: [Cart] = []

        while true {
            for i in 0..<self.totalCarts - 1 {
                carts.append(Cart(totalPassengers: self.totalPassengers, carId: "Car\(i)"))

                for j in 0..<self.totalPassengers {
                    DispatchQueue(label: "passenger-queue-\(j)", attributes: .concurrent).async {
                        carts[i].passengerTriesToGetInCar(passengerId: j)
                    }
                    sleep(2)
                }

                if carts[i].carIsRunning() {
                    print("\nThe car \(carts[i].carId) is running...uiiiiii\n")
                }

                sleep(5)
                carts[i].passengerLeftTheCar()
            }
        }
    }
}

class Main {
    let totalPassengers = 5
    let totalCarts = 4

    func main() {
        print("_____Initializing The Roller Coaster_____")

        RollerCoaster(
            totalPassengers: totalPassengers,
            totalCarts: totalCarts
        ).initRollerCoaster()
    }
}
