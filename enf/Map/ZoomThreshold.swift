
func getZoomThreshold(for location:Location) -> Double {
    switch location.color{
    case .red: return 0.07
    case .blue: return 12
    case .green: return 1
    case .yellow: return 5
    default: return 0.1
    }
}
