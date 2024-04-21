
import Foundation

struct Crew: Codable {
    
	let id: Int?
	let creditId: String?
	let name: String?
	let department: String?
	let job: String?
	let gender: Int?
	let profilePath: String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case creditId = "credit_id"
		case name = "name"
		case department = "department"
		case job = "job"
		case gender = "gender"
		case profilePath = "profile_path"
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
	}

}
