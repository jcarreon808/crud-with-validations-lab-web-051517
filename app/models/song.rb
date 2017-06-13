class Song < ActiveRecord::Base
  validates :title, presence:true
  validate :norepeats
  validates :release_year, presence:true, if: :released
  validate :future_release_year


  def norepeats
    song = Song.where(title:title,release_year:release_year, artist_name:artist_name).limit(1).first
    if !song.nil?
      errors.add(:song, "NO REPEATS!")
    end
  end

  def future_release_year
    if !release_year.nil?
      if release_year > Date.today.year
        errors.add(:date, 'Too far from now')
      end
    end
  end

end
