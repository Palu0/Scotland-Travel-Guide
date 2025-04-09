import CoreLocation

func distance(location1: Location, location2: CLLocation) -> Int {
    let earthRadiusKM: Double = 6371.0 // Earth's radius in kilometers

    let lat1 = location1.latitude * .pi / 180  // Convert degrees to radians
    let lon1 = location1.longitude * .pi / 180
    let lat2 = location2.coordinate.latitude * .pi / 180
    let lon2 = location2.coordinate.longitude * .pi / 180

    let dLat = lat2 - lat1
    let dLon = lon2 - lon1

    let a = sin(dLat / 2) * sin(dLat / 2) +
            cos(lat1) * cos(lat2) *
            sin(dLon / 2) * sin(dLon / 2)

    let c = 2 * atan2(sqrt(a), sqrt(1 - a))
    let distanceKM = earthRadiusKM * c // Distance in kilometers

    return Int(distanceKM)
}
