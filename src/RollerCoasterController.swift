import Foundation

class RollerCoasterController {
    private var availableSets: Int = 0
    private let carCapacity: Int
    private var rollerCoasterWorking: Bool = false
    private var passengersRiding: Bool = true
    private let carQueue = DispatchQueue(label: "car-queue", attributes: .concurrent)
    private let passengerQueue = DispatchQueue(label: "passenger-queue", attributes: .concurrent)
    private let carSemaphore = DispatchSemaphore(value: 4)
    private let passengerSemaphore = DispatchSemaphore(value: 1)

    public init(carCapacity: Int) {
        self.carCapacity = carCapacity
    }

    func carIsFull() -> Bool {
        if (!passengersRiding && availableSets > 0 && (availableSets <= self.carCapacity)) {
            availableSets -= 1
            return true
        }

        return false
    }

    func passengerTriesToGetInCar(passengerId: Int) {
        _ = passengerQueue.sync {
            while (!carIsFull()) {
                passengerSemaphore.wait()
            }
        }

        print("The Passenger \(passengerId) gets in car")

        _ = carQueue.sync {
            carSemaphore.signal()
        }
    }

    func carIsRunning() -> Bool {
        if (availableSets == 0) {
            availableSets = self.carCapacity
            rollerCoasterWorking = true
            passengersRiding = true
            return true
        }

        return false
    }

    func passengerGetOnCar(carId: Int) {
        _ = carQueue.sync {
            while (!carIsRunning()) {
                carSemaphore.wait()
            }
        }

        print("The car is full and starts running")

        _ = passengerQueue.sync {
            passengerSemaphore.signal()
        }
    }

    func passengerLeftTheCar(carId: Int) {
        passengersRiding = false
        rollerCoasterWorking = false

        _ = passengerQueue.sync {
            passengerSemaphore.signal()
        }
    }

}