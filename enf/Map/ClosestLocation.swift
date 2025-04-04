import CoreLocation
func squared(number: Double) -> Double {
    return number * number
}

func distance(location1: Location, location2:CLLocation) -> Double{
    return abs(sqrt(squared(number: (location1.latitude - location2.coordinate.latitude)) + squared(number: (location1.longitude - location2.coordinate.longitude))))
}
