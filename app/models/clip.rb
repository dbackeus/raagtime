class Clip < ActiveRecord::Base
  belongs_to :raga, touch: true, counter_cache: true

  validates_presence_of :raga
  validates_presence_of :url
  validates_presence_of :title, if: :url
  validates_uniqueness_of :url, scope: :raga_id
  validate :validate_info, if: lambda { url.present? }

  before_validation :set_attributes_from_info, if: :info

  def info
    @video_info ||= VideoInfo.get(url)
  rescue VideoInfo::UrlError => e
    if e.message.downcase.include? "url is not usable"
      nil
    else
      raise
    end
  end

  private

  def validate_info
    errors.add(:url, :invalid) unless info
  end

  def set_attributes_from_info
    self.title = self.title.presence || info.title
    self.thumbnail_url = info.thumbnail_medium
    self.embed_code = info.embed_code(iframe_attributes: { width: 425, height: 344 })
  end
end
