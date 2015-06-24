require_relative "../../util/cyphertools.rb"
require_relative "../cypher.rb"

class Vigenere	
	class VigenereKey < Cypher::Key

		RandLenMax = 16
		RandLenMin = 8

		attr_reader :shift

		def initialize(phrase)
			@shift = CypherTools::Text.only_alpha(phrase).downcase
			super(@shift)
		end

		def self.random
			randLength = RandLenMin + rand(RandLenMax - RandLenMin)
			self.new(CypherTools::Text.garbage_alpha(randLength))
		end
		
	end
end