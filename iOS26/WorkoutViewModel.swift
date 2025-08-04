import Combine
import Foundation

class WorkoutViewModel: ObservableObject {
    @Published var progress: CGFloat = 0
    @Published var state: WorkoutStage = .initial
        
    func startWorkout() {
        state = .started
        progress = 1
    }
    
    func finishWorkout() {
        // TODO: popup modal summary screen
        state = .initial
        progress = 0
    }
    
    func pickRestTime() {
        state = .picker
        progress = 1
    }
}


enum RestTimeSeconds: Int, CaseIterable, CustomStringConvertible {
    case short = 30
    case medium = 60
    case long = 120
    case veryLong = 180
    
    var description: String {
        switch self {
        case .short:
            return "30 sec"
        case .medium:
            return "1 min"
        case .long:
            return "2 min"
        case .veryLong:
            return "3 min"
        }
    }
}

enum WorkoutStage {
    case initial
    case started
    case typing
    case picker
    case resting
    case summary
}

