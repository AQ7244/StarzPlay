
import Foundation

struct SeasonModel: Codable {
    
	let _id: String?
	let airDate: String?
	let episodes: [Episodes]?
	let name: String?
	let overview: String?
	let id: Int?
	let posterPath: String?
	let seasonNumber : Int?

	enum CodingKeys: String, CodingKey {

		case _id = "_id"
		case airDate = "air_date"
		case episodes = "episodes"
		case name = "name"
		case overview = "overview"
		case id = "id"
		case posterPath = "poster_path"
		case seasonNumber = "season_number"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		_id = try values.decodeIfPresent(String.self, forKey: ._id)
        airDate = try values.decodeIfPresent(String.self, forKey: .airDate)
		episodes = try values.decodeIfPresent([Episodes].self, forKey: .episodes)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        seasonNumber = try values.decodeIfPresent(Int.self, forKey: .seasonNumber)
	}

}
