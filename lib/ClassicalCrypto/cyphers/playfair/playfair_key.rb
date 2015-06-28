require_relative "../../utils.rb"
require_relative "../cypher.rb"

class ClassicalCrypto::Cyphers::Playfair

	require_relative "playfair_table.rb"

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: PlayfairKey
	#
	#~~Description: PlayfairKey is a subclass of Key which stores key data for the
	#~~Playfair cypher. 
	#
	#~~Constructor: PlayfairKey.new(phrase)
	#~~Initializes PlayfairTable with phrase.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	class PlayfairKey < Key

		attr_reader :table

		def initialize(phrase)
			unless phrase.is_a? String
				raise TypeError, "no implicit conversion of #{phrase.inspect}:#{phrase.class} to String given"
			end

			@table = PlayfairTable.new(phrase)
			
			super phrase
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: self.random #=> PlayfairKey
		#
		#~~Description: returns a PlayfairKey generated with a randomly ordered alphabet as
		#~~a phrase.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def self.random
			self.new ClassicalCrypto::Utils::Text.jumble_alpha
		end
	end
end