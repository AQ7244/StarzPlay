
import Foundation

struct Crew: Codable {
    
	let id: Int?
	let creditId: String?
	let name: String?
	let department: String?
	let job: String?
	let gender: Int?
	let profilePath: String?
    let adult: Bool?
    let knownForDepartment: KnownForDepartment?
    let originalName: String?
    let popularity: Double?
    let character: String?
    let order: Int?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case creditId = "credit_id"
		case name = "name"
		case department = "department"
		case job = "job"
		case gender = "gender"
		case profilePath = "profile_path"
        case adult
        case knownForDepartment = "known_for_department"
        case originalName = "original_name"
        case popularity
        case character
        case order
	}

	init(from decoder: Decoder) throws {
        
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
        creditId = try values.decodeIfPresent(String.self, forKey: .creditId)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		department = try values.decodeIfPresent(String.self, forKey: .department)
		job = try values.decodeIfPresent(String.self, forKey: .job)
		gender = try values.decodeIfPresent(Int.self, forKey: .gender)
		profilePath = try values.decodeIfPresent(String.self, forKey: .profilePath)
        adult = try values.decodeIfPresent(Bool.self, forKey: .adult)
        knownForDepartment = try values.decodeIfPresent(KnownForDepartment.self, forKey: .knownForDepartment)
        originalName = try values.decodeIfPresent(String.self, forKey: .originalName)
        popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        character = try values.decodeIfPresent(String.self, forKey: .character)
        order = try values.decodeIfPresent(Int.self, forKey: .order)
	}

}

enum KnownForDepartment: String, Codable {
    
    case acting = "Acting"
    case crew = "Crew"
    case directing = "Directing"
    case writing = "Writing"
}
