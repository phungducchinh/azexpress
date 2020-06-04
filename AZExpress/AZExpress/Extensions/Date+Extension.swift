
import Foundation

extension Date {
    static func now() -> Date {
        return Date();
    }
    
    func dateComponents(with date: Date, timeZone: TimeZone) -> (month: Int, day: Int, year: Int) {
        var calendar = Calendar(identifier: .gregorian);
        calendar.timeZone = timeZone;
        let components = calendar.dateComponents([.day, .month, .year], from: date);
        return (components.month!, components.day!, components.year!);
    }
    
    enum TimeMoment {
        case beginOfDay;
        case endOfDay;
    }
    
    static func date(withMoment moment: TimeMoment, month: Int, day: Int, year: Int, timeZone: TimeZone) -> Date? {
        var calendar = Calendar(identifier: .gregorian);
        calendar.timeZone = timeZone;
        var components = DateComponents();
        components.timeZone = timeZone;
        components.day = day;
        components.month = month;
        components.year = year;
        
        components.hour = 0;
        components.minute = 0;
        components.second = 0;
        
        switch moment {
        case .beginOfDay:
            break;
            
        case .endOfDay:
            components.day = day + 1;
            components.second = -1;
        }
        
        return calendar.date(from: components);
    }
}
