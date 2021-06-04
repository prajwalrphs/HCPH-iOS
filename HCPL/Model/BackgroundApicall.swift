
import Foundation


struct BackgroundApicall: Codable {
    let isSuccess: Bool
    let data: [DatumBackground]
    let message: String
    let createdID, pageIndex, pageSize, totalCount: Int
    let totalPageCount: Int
    let hasPreviousPage, hasNextPage: Bool
}

// MARK: - Datum
struct DatumBackground: Codable {
    let count: Int
    let establishmentNumber, facilityType, establishmentName, streetNumber: String
    let streetAddress, city, zipCode, lon: String
    let lat, demerits, lastInspection, permitExpireDate: String
    let milesAway: String
    let numInspections: Int
}
