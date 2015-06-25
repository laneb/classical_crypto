require_relative "../../utils.rb"
require_relative "../cypher.rb"

class ClassicalCrypto::Cyphers::Vigenere	
	class VigenereKey < Key

		RandLenMax = 16
		RandLenMin = 8

		attr_reader :shift

		def initialize(phrase)
			@shift = ClassicalCrypto::Utils::Text.only_alpha(phrase).downcase
			super(@shift)
		end

		def self.random
			randLength = RandLenMin + rand(RandLenMax - RandLenMin)
			self.new(ClassicalCrypto::Utils::Text.garbage_alpha(randLength))
		end
		
	end
end