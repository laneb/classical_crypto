class ClassicalCrypto::Cyphers::Caesar


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: CaesarKey
	#
	#~~Description: CaesarKey is a subclass of Key which stores key data for the
	#~~Caesar cypher. 
	#
	#~~Constructor: CaesarKey.new(shift_char)
	#~~Stores shift_char, the character indicating the magnitude of the shift e.g.
	#~~an 'a'-shift (magnitude 0) or a 'z'-shift (magnitude 25)
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	class CaesarKey < Key

		attr_reader :shift_num

		def initialize(shiftCh)
			raise TypeError, "no implicit coercion of #{shiftCh.class} to String" unless shiftCh.is_a? String
			raise ArgumentError, "shift string must be of length 1" unless shiftCh.length == 1 
			raise ArgumentError, "shift character must be alphabetic" unless ClassicalCrypto::Utils::Text.alpha? shiftCh

			@shift_num = shiftCh.downcase.ord - 'a'.ord

			super shiftCh
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: self.random #=> CaesarKey
		#
		#~~Description: returns an CaesarKey generated with random alphabetic character
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def self.random
			randShiftCh = ClassicalCrypto::Utils::Text.rand_alpha
			self.new randShiftCh
		end

	end
end