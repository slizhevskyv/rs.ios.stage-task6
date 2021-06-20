import Foundation

typealias RangeDistance = (start: Int, end: Int);
typealias RangeDistanceWithFreeSeats = (start: Int, end: Int, freeSeat: Int);

class CoronaClass {
    
    var seats = [Int]()
    let seatsCount: Int;


    init(n: Int) {
        self.seatsCount = n;
    }

    func seat() -> Int {
        let firstSeat = seats.first;
        
        if (firstSeat == nil || firstSeat != 0) {
            seats.insert(0, at: 0);
            return 0;
        }
        
        if (seats.count == 1 || seats[seats.count - 1] != seatsCount - 1) {
            seats.append(seatsCount - 1);
            return seatsCount - 1;
        }
        
        seats.sort(by: <)
        
        let seatIndex = findSeat();
        
        seats.append(seatIndex);
        
        seats.sort(by: <)
        
        return seatIndex;
    }
    
    private func findSeat() -> Int {
        var distance: [RangeDistance] = [];
        
        for i in 0..<seats.count {
            for j in (i + 1)..<seats.count {
                distance.append((seats[i], seats[j]))
                break;
            }
        }
        
        var distanceToTheMiddleIndexWithFreeSeats: [RangeDistanceWithFreeSeats] = [];
        
        for distanceRange in distance {
            let middleIndex = Float((distanceRange.start + distanceRange.end)) / 2;
            
            if (middleIndex == middleIndex.rounded(.down)) {
                distanceToTheMiddleIndexWithFreeSeats.append((
                    distanceRange.start,
                    Int(middleIndex),
                    Int(middleIndex) - distanceRange.start
                ))
                distanceToTheMiddleIndexWithFreeSeats.append((
                    Int(middleIndex),
                    distanceRange.end,
                    distanceRange.end - Int(middleIndex)
                ))
            } else {
                let roundeDownMiddleIndex = middleIndex.rounded(.down);
                let roundeUpMiddleIndex = middleIndex.rounded(.up);
                
                distanceToTheMiddleIndexWithFreeSeats.append((
                    distanceRange.start,
                    Int(roundeDownMiddleIndex),
                    Int(roundeDownMiddleIndex) - distanceRange.start
                ));
                
                distanceToTheMiddleIndexWithFreeSeats.append((
                    Int(roundeUpMiddleIndex),
                    distanceRange.end,
                    distanceRange.end - Int(roundeUpMiddleIndex)
                ));
            }
        }
        
        let seatIndex = distanceToTheMiddleIndexWithFreeSeats.sorted(by: { $0.freeSeat > $1.freeSeat }).first!.end
        
        return seatIndex;
    }

    func leave(_ p: Int) {
        seats.remove(at: seats.firstIndex(of: p)!);
    }
}
