class Raga < ActiveRecord::Base
  has_many :clips, dependent: :delete_all

  validates_presence_of :title
  validates_presence_of :ascending_scale
  validates_presence_of :descending_scale
  validates_uniqueness_of :title, case_sensitive: false

  acts_as_url :title, sync_url: true, url_attribute: "slug"

  scope :playable, -> { where("spotify_playlist_url IS NOT NULL OR clips_count > 0") }

  def self.time_options
    ActiveSupport::OrderedHash[
      "06-09", "1",
      "09-12", "2",
      "12-15", "3",
      "15-18", "4",
      "18-21", "5",
      "21-24", "6",
      "24-03", "7",
      "03-06", "8",
      "Monsoon", "m"
    ]
  end

  def self.chakra_options
    ActiveSupport::OrderedHash[
      "Left Mooladhara", "left_mooladhara",
      "Mooladhara", "mooladhara",
      "Right Mooladhara", "right_mooladhara",
      "Left Swadisthan", "left_swadisthan",
      "Swadisthan", "swadisthan",
      "Right Swadisthan", "right_swadisthan",
      "Left Nabhi", "left_nabhi",
      "Nabhi", "nabhi",
      "Right Nabhi", "right_nabhi",
      "Void", "void",
      "Left Heart", "left_heart",
      "Heart", "heart",
      "Right Heart", "right_heart",
      "Left Vishuddhi", "left_vishuddhi",
      "Vishuddhi", "vishuddhi",
      "Right Vishuddhi", "right_vishuddhi",
      "Left Agnya", "left_agnya",
      "Agnya", "agnya",
      "Right Agnya", "right_agnya",
      "Left Sahastrara", "left_sahasrara",
      "Sahastrara", "sahasrara",
      "Right Sahastrara", "right_sahasrara"
    ]
  end

  def to_s
    title
  end

  def to_param
    slug
  end

  def pretty_time
    self.class.time_options.invert[time]
  end

  def pretty_chakra
    self.class.chakra_options.invert[chakra]
  end

  # Strip beginning of "Rag Puriya Kalyan: spotify:user:duztdruid:playlist:11Nsl0P9qDqbvDTwu5WB5d")
  def spotify_playlist_url=(url)
    if url.present?
      url = url["spotify:"] ? url[url.rindex("spotify:")..-1] : url #
      write_attribute(:spotify_playlist_url, url)
    end
  end
end
