require_relative "../../utils.rb"
require_relative "../cypher.rb"

class ClassicalCrypto::Cyphers::FourSquare

	require_relative "foursquare_table.rb"

	class FourSquareKey < Key

		attr_reader :table

		def initialize(phrase1, phrase2)
			[phrase1, phrase2].each do |phrase|
				unless phrase.is_a? String
					raise TypeError, "no implicit conversion of #{phrase.class} to String" 
				end
			end

			@table = FourSquareTable.new(phrase1, phrase2)
			super(@table)
		end	


		def self.random
			self.new ClassicalCrypto::Utils::Text.jumble_alpha, ClassicalCrypto::Utils::Text.jumble_alpha
		end

	end
end