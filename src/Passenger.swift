import Foundation

class Passenger {
    private var passengerId: Int
    private let rcController: RollerCoasterController

    public init(passengerId: Int, rcController: RollerCoasterController) {
        self.passengerId = passengerId
        self.rcController = rcController
    }

    func passengerActions() {
        while (true) {
            sleep(5)
            rcController.passengerTriesToGetInCar(passengerId: passengerId)
        }
    }
}