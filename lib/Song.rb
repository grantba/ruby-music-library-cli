#require 'pry'

class Song

    attr_accessor :name, :artist, :genre
    @@all = []
    
    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist != nil
        self.genre = genre if genre != nil
        save
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
        genre.songs << self unless genre.songs.include?(self)
    end

    def save
        @@all << self unless @@all.include?(self)
    end

    def self.create(name)
        song = self.new(name)
        song.save
        song
    end
    
    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def self.find_by_name(song)
        self.all.detect {|s| s.name == song}
    end

    def self.find_or_create_by_name(song)
        find_by_name(song) || create(song)
    end

    def self.new_from_filename(file_name)
        array = file_name.split(" - ")

        artist = array[0]
        name = array[1]
        genre = array[2].gsub(".mp3", "")

        artist = Artist.find_or_create_by_name(artist)
        genre = Genre.find_or_create_by_name(genre)
        self.new(name, artist, genre)
    end

    def self.create_from_filename(file_name)
        self.new_from_filename(file_name)
    end
    #binding.pry
end