require 'set'
require 'rest_client'
require 'rubygems'
require 'json'
require 'thread'

API_KEY = 'a1e481157e9266184ff5121b194c40d2'
SONG_LIST_FILENAME = 'musicList.txt'
OUTPUT_FILE = 'recommendedSongs.txt'

def Exception.ignoring_exceptions
  begin
    yield
  rescue Exception => e
    STDERR.puts e.message
  end
end
module Enumerable
  def in_parallel_n(n)
    todo = Queue.new
    ts = (1..n).map{
      Thread.new{
        while x = todo.deq
          Exception.ignoring_exceptions{ yield(x[0]) }
        end
      }
    }
    each{|x| todo << [x]}
    n.times{ todo << nil }
    ts.each{|t| t.join}
  end
end

class Song
  def title
    @title
  end
  def title=(title)
    @title = title
  end
  def artist
    @artist
  end
  def artist=(artist)
    @artist = artist
  end
  def weight
    @weight
  end
  def weight=(weight)
    @weight = weight
  end
end

songs = {}
songCount = %x{wc -l < "#{SONG_LIST_FILENAME}"}.to_i
index = 0
inputtedSongs = Set.new

lineList = []

file = File.new(SONG_LIST_FILENAME, "r")
while (line = file.gets)
  lineList << line
end
file.close

lineList.in_parallel_n(30) do |line|
  puts " * Evaluating track " + index.to_s + " of " + songCount.to_s
  index+=1

  lineArray = line.split(' *by* ')
  begin
    if lineArray.length == 1
      puts "SKIPPED " + lineArray.to_s
      next
    end
  rescue
    puts "SKIPPED " + lineArray.to_s
    next
  end
  title = lineArray[0].strip
  artist = lineArray[1].strip
  inputtedSongs.add((title+artist).strip.downcase)

  response = nil
  begin
    response = RestClient.get 'http://ws.audioscrobbler.com/2.0/', :params => {:method => 'track.getsimilar', :artist => artist, :track => title, :api_key => API_KEY, :format => 'json'}
  rescue => e
    e.response
    next
  end
  if response == nil
    next
  end

  similarTracks = JSON.parse(response)['similartracks']
  if similarTracks == nil or similarTracks['track'] == nil or similarTracks['track'] == title
    puts "SKIPPED " + title + " by " + artist
    next
  end

  similarTracks = similarTracks['track']
  begin
    if similarTracks.length > 1
      similarTracks.each do |track|
        song = Song.new
        song.title = track['name']
        song.artist = track['artist']['name']
        song.weight = 0
        if songs[song.title+song.artist] == nil
          songs[song.title+song.artist] = song
        end
        songs[song.title+song.artist].weight += Float(track['match'])
      end
    end
  rescue
    song = Song.new
    song.title = similarTracks['name']
    if song.title == nil
      next
    end
    song.artist = similarTracks['artist']['name']
    song.weight = 0
    if songs[song.title+song.artist] == nil
      songs[song.title+song.artist] = song
    end
    songs[song.title+song.artist].weight += Float(similarTracks['match'])
  end
end


songs.keep_if {|key,value|
  inputtedSongs.include?(key.strip.downcase) == false}

puts "\n*** Top 40 Recommended Songs ***"
songs_array = []
songs.each do |key, value|
  songs_array << value
end

songs_array = songs_array.sort do |a, b|
  b.weight <=> a.weight
end

cutoff = 0.7 # songCount / 58.0;
File.open(OUTPUT_FILE, 'w') do |file|
  index = 0
  songs_array.each do |song|
    if song.weight > cutoff and (inputtedSongs.include?((song.title + song.artist).strip.downcase) == false)
      if index < 40
        puts " " + (index+1).to_s + ". " + song.title + " by " + song.artist + "\t Score: " + song.weight.round(2).to_s
      end
      file.puts "Title: " + song.title + "\tArtist: " + song.artist + "\tWeight: " + song.weight.round(2).to_s
    end
    index += 1
  end
end

puts "\nWrote all recommended songs to " + OUTPUT_FILE
