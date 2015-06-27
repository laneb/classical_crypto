require_relative "../utils.rb"



module ClassicalCrypto::Cyphers

	ALPHA_ONLY_PTEXT = false
	EVEN_LENGTH_CTEXT = false

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: Cypher
	#~~Constructor: Cyper.new(key_part, )
	#
	#~~Description: Cypher is a virtual class to be implemented by the cypher classes in this library
	#~~It outlines the functionality expected of each system and includes every method that 
	#~~will be visible to the user. Cypher also manages case and whitespace problems.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	protected

	class Cypher

		require_relative "cypher/key.rb"

		@keyType = Key

		attr_reader :key

		def initialize(*key_data)
			if key_data.empty?
				@key = self.class.keyType.random
			else 
				@key = self.class.keyType.new(*key_data)
			end
		end


		def self.random
			self.new
		end

		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: encrypt(ptext)
		#
		#~~Description: The method that users will use to encrypt the plaintext. Encapsulates downcasing
		#~~and removing whitespace from the input string and upcasing the output, while each cypher 
		#~~must implement an encode method for the actual transformation from plaintext to cyphertext.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def encrypt(ptext)

			if ALPHA_ONLY_PTEXT and ptext.match /\d/ then raise ArgumentError, "plaintext may not include digits" end

			encode(ClassicalCrypto::Utils::Text.only_alnum(ptext.downcase)).upcase
		end 


		require_relative "cypher/pure_alphabetic_plaintext.rb"


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: decrypt(ctext)
		#
		#~~Description: The method that users will use to decrypt the cyphertext. Encapsulates 
		#~~upcasingand removing whitespace from the input string and downcasing the output, while 
		#~~each cypher must implement an encode method for the actual transformation from plaintext 
		#~~to cyphertext.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def decrypt(ctext)

			if EVEN_LENGTH_CTEXT and ctext.odd? then raise ArgumentError, "cyphertext must be of even length" end

			decode(ClassicalCrypto::Utils::Text.only_alnum(ctext.upcase)).downcase
		end


		protected

		def self.set_key_type_to(keyType)
			@keyType = keyType
		end


		def self.keyType
			@keyType
		end
		
	end
end