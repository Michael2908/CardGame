

import Foundation

class TimeConv  {
    static func prettyPrintSecToHHss(_ sec : Int) ->String{
        let seconds = String(format: "%02d", (sec%60))
        let minutes = String(format: "%02d", sec/60)
        let txt = "\(minutes):\(seconds)"
        return txt
    }
}
