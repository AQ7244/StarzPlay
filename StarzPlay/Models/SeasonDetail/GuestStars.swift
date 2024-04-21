
import Foundation

struct GuestStars: Codable {
    
	let id: Int?
	let name: String?
	let creditId: String?
	let character : String?
	let order : Int?
	let gender : Int?
	let profilePath : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case creditId = "credit_id"
		case character = "character"
		case order = "order"
		case gender = "gender"
		case profilePath = "profile_path"
	}

	init(from decoder: Decoder) throws {
        
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
        creditId = try values.decodeIfPresent(String.self, forKey: .creditId)
		character = try values.decodeIfPresent(String.self, forKey: .character)
		order = try values.decodeIfPresent(Int.self, forKey: .order)
		gender = try values.decodeIfPresent(Int.self, forKey: .gender)
		profilePath = try values.decodeIfPresent(String.self, forKey: .profilePath)
	}

}
