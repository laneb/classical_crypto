require_relative "../../utils.rb"
require_relative "../cypher.rb"

class ClassicalCrypto::Cyphers::Vigenere

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: VigenereKey
	#
	#~~Description: VigenereKey is a subclass of Key which stores key data for the
	#~~Vigenere cypher. 
	#
	#~~Constructor: VigenereKey.new(phrase)
	#~~Removes whitespace from and downcases String :phrase: and stores the result as
	#~~the shift string, which is used to shift each period of the plaintext.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	class VigenereKey < Key

		RandLenMax = 16
		RandLenMin = 8

		attr_reader :shift


		def initialize(phrase)
			raise TypeError, "no implicit coercion of #{phrase} to String" unless phrase.is_a? String
			#@shift stores the shift string, which is used to shift each period of the plaintext
			@shift = ClassicalCrypto::Utils::Text.only_alpha(phrase).downcase
			super(@shift)
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: self.random #=> VigenereKey
		#
		#~~Description: returns a VigenereKey generated with a randomly generatedd shift string
		#~~with length between 8 and 16
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def self.random
			randLength = RandLenMin + rand(RandLenMax - RandLenMin)
			self.new(ClassicalCrypto::Utils::Text.garbage_alpha(randLength))
		end
		
	end
end