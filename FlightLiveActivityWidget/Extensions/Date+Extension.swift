import Foundation


extension Date {
    func toDDMMAAHHMM() -> String {
        let dateFormatter = DateFormatter()
        
        // Establecer el formato para el billete de avión
        dateFormatter.dateFormat = "d/MM/yy HH:mm"
        dateFormatter.locale = Locale(identifier: "en_US")

        return dateFormatter.string(from: self)
    }
}
