
func getZoomThreshold(for location:Location) -> Double {
    if location.latitude < 56 && location.latitude > 55 {
        return 0.07
    }
    else {
            switch location.color{
            case .red: return 0.07
            case .blue: return 12
            case .green: return 1
            case .yellow: return 5
            default: return 0.1
            }
        }
    }

