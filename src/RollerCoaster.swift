import Foundation

class RollerCoaster {
    let totalPassengers = 25
    let totalCars = 1
    let carCapacity = 4

    func initRollerCoaster() {
        let rcController: RollerCoasterController = RollerCoasterController(carCapacity: carCapacity)

        for i in 0..<totalPassengers {
            let passenger = Passenger(passengerId: i, rcController: rcController)
            passenger.passengerActions()
        }

        for i in 0..<totalCars {
            let car = Car(carId: i, rcController: rcController)
            car.carActions()
        }
    }
}

RollerCoaster().initRollerCoaster()