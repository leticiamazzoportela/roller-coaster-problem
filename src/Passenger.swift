class Passenger {
    private var passengerId: Int // The passenger ID
    private var isWalkingInThePark: Bool // Flag that identifies whether the passenger is walking in the park after riding in the cart

    public init(passengerId: Int) {
        self.passengerId = passengerId
        self.isWalkingInThePark = false
    }

    func getPassengerId() -> Int {
        return passengerId
    }

    func setPassengerCanWalkingInTheParkLater(_ isWalkingInThePark: Bool) {
        self.isWalkingInThePark = isWalkingInThePark
    }

    func getPassengerIsWalkingInThePark() -> Bool {
        return isWalkingInThePark
    }
}