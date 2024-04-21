
import Foundation

struct ShowBase: Codable {
    
	let backdropPath: String?
	let createdBy: [CreatedBy]?
	let episodeRunTime: [Int]?
	let firstAirDate: String?
	let genres: [Genres]?
	let homepage: String?
	let id : Int?
	let inProduction: Bool?
	let languages: [String]?
	let lastAirDate: String?
	let lastEpisodeToAir: LastEpisodeToAir?
	let name: String?
	let nextEpisodeToAir: NextEpisodeToAir?
	let networks: [Networks]?
	let numberOfEpisodes: Int?
	let numberOfSeasons: Int?
	let originCountry: [String]?
	let originalLanguage: String?
	let originalName: String?
	let overview: String?
	let popularity: Double?
	let posterPath: String?
	let productionCompanies: [ProductionCompanies]?
	let seasons: [Seasons]?
	let status: String?
	let type: String?
	let voteAverage : Double?
	let voteCount : Int?

	enum CodingKeys: String, CodingKey {

		case backdropPath = "backdrop_path"
		case createdBy = "created_by"
		case episodeRunTime = "episode_run_time"
		case firstAirDate = "first_air_date"
		case genres = "genres"
		case homepage = "homepage"
		case id = "id"
		case inProduction = "in_production"
		case languages = "languages"
		case lastAirDate = "last_air_date"
		case lastEpisodeToAir = "last_episode_to_air"
		case name = "name"
		case nextEpisodeToAir = "next_episode_to_air"
		case networks = "networks"
		case numberOfEpisodes = "number_of_episodes"
		case numberOfSeasons = "number_of_seasons"
		case originCountry = "origin_country"
		case originalLanguage = "original_language"
		case originalName = "original_name"
		case overview = "overview"
		case popularity = "popularity"
		case posterPath = "poster_path"
		case productionCompanies = "production_companies"
		case seasons = "seasons"
		case status = "status"
		case type = "type"
		case voteAverage = "vote_average"
		case voteCount = "vote_count"
	}

	init(from decoder: Decoder) throws {
        
		let values = try decoder.container(keyedBy: CodingKeys.self)
        backdropPath = try values.decodeIfPresent(String.self, forKey: .backdropPath)
        createdBy = try values.decodeIfPresent([CreatedBy].self, forKey: .createdBy)
        episodeRunTime = try values.decodeIfPresent([Int].self, forKey: .episodeRunTime)
        firstAirDate = try values.decodeIfPresent(String.self, forKey: .firstAirDate)
		genres = try values.decodeIfPresent([Genres].self, forKey: .genres)
		homepage = try values.decodeIfPresent(String.self, forKey: .homepage)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
        inProduction = try values.decodeIfPresent(Bool.self, forKey: .inProduction)
		languages = try values.decodeIfPresent([String].self, forKey: .languages)
        lastAirDate = try values.decodeIfPresent(String.self, forKey: .lastAirDate)
        lastEpisodeToAir = try values.decodeIfPresent(LastEpisodeToAir.self, forKey: .lastEpisodeToAir)
		name = try values.decodeIfPresent(String.self, forKey: .name)
        nextEpisodeToAir = try values.decodeIfPresent(NextEpisodeToAir.self, forKey: .nextEpisodeToAir)
		networks = try values.decodeIfPresent([Networks].self, forKey: .networks)
        numberOfEpisodes = try values.decodeIfPresent(Int.self, forKey: .numberOfEpisodes)
        numberOfSeasons = try values.decodeIfPresent(Int.self, forKey: .numberOfSeasons)
        originCountry = try values.decodeIfPresent([String].self, forKey: .originCountry)
        originalLanguage = try values.decodeIfPresent(String.self, forKey: .originalLanguage)
        originalName = try values.decodeIfPresent(String.self, forKey: .originalName)
		overview = try values.decodeIfPresent(String.self, forKey: .overview)
		popularity = try values.decodeIfPresent(Double.self, forKey: .popularity)
        posterPath = try values.decodeIfPresent(String.self, forKey: .posterPath)
        productionCompanies = try values.decodeIfPresent([ProductionCompanies].self, forKey: .productionCompanies)
		seasons = try values.decodeIfPresent([Seasons].self, forKey: .seasons)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		type = try values.decodeIfPresent(String.self, forKey: .type)
        voteAverage = try values.decodeIfPresent(Double.self, forKey: .voteAverage)
		voteCount = try values.decodeIfPresent(Int.self, forKey: .voteCount)
	}

}
