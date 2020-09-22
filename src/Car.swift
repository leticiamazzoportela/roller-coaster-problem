import Foundation

class Car {
    private var carId: Int
    private let rcController: RollerCoasterController

    public init(carId: Int, rcController: RollerCoasterController) {
        self.carId = carId
        self.rcController = rcController
    }

    func carActions() {
        while (true) {
            rcController.passengerGetOnCar(carId: carId)
            sleep(5)
            rcController.passengerLeftTheCar(carId: carId)
        }
    }
}