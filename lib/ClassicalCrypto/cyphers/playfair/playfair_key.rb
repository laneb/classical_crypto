require_relative "../../util/cyphertools.rb"
require_relative "../cypher.rb"

class Playfair

	require_relative "playfair_table.rb"

	class PlayfairKey < Cypher::Key

		attr_reader :table

		def initialize(phrase)
			unless phrase.is_a? String
				raise TypeError, "no implicit conversion of #{phrase.inspect}:#{phrase.class} to String given"
			end

			@table = PlayfairTable.new(phrase)
			
			super @table
		end

		def self.random
			self.new CypherTools::Text.jumble_alpha
		end
	end
end