require_relative "../../utils.rb"
require_relative "../cypher.rb"

class ClassicalCrypto::Cyphers::Playfair

	require_relative "playfair_table.rb"

	class PlayfairKey < Key

		attr_reader :table

		def initialize(phrase)
			unless phrase.is_a? String
				raise TypeError, "no implicit conversion of #{phrase.inspect}:#{phrase.class} to String given"
			end

			@table = PlayfairTable.new(phrase)
			
			super @table
		end

		def self.random
			self.new ClassicalCrypto::Utils::Text.jumble_alpha
		end
	end
end