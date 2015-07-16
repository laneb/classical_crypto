require_relative "../utils.rb"



module ClassicalCrypto::Cyphers

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: Cypher
	#
	#~~Description: Cypher is a virtual class to be implemented by the cypher classes in this library
	#~~It outlines the functionality expected of each system and includes every method that 
	#~~will be visible to the user. Cypher also manages case and whitespace problems.
	#
	#~~Constructor: Cypher.new(keyDatum, )
	#~~Sets key data to data specified in the arguments. Will raise error if data does not 
	#~~match data expected by the key.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	protected

	class Cypher


		@plaintext_alphabet = "abcdefghijklmnopqrstuvwxyz0123456789"
		@cyphertext_alphabet = "ABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"
		@expect_even_length_ctext = false


		require_relative "cypher/key.rb"

		attr_reader :key

		def initialize(*key_data)
			if key_data.empty?
				@key = self.class.key_type.random
			else 
				@key = self.class.key_type.new(*key_data)
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
		#~~must implement an _encrypt_ method for the actual transformation from plaintext to cyphertext.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def encrypt(ptext)
			unless ptext.is_a? String 
				raise TypeError, "no implicit coercion of #{ptext} to String"
			end

			
			if ptext.match /[^#{self.class.plaintext_alphabet}]/ 
				raise ArgumentError, "plaintext may only include the following characters: #{self.class.plaintext_alphabet}"
			end

			begin
				
				ctext = _encrypt_(ptext).upcase
			
			rescue Exception => error

				raise error

			end

			ctext
		end 


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: decrypt(ctext)
		#
		#~~Description: The method that users will use to decrypt the cyphertext. Encapsulates 
		#~~upcasingand removing whitespace from the input string and downcasing the output, while 
		#~~each cypher must implement an _encrypt_ method for the actual transformation from plaintext 
		#~~to cyphertext.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def decrypt(ctext)
			unless ctext.is_a? String 
				raise TypeError, "no implicit coercion of #{ptext} to String"
			end

			if ctext.match /[^#{self.class.cyphertext_alphabet}]/ 
				raise ArgumentError, "cyphertext may only include the following characters: #{self.class.cyphertext_alphabet}"
			end

			if self.class.expect_even_length_cyphertext? and ctext.length.odd? 
				raise ArgumentError, "cyphertext must be of even length"
			end
			
			begin
				
				ptext = _decrypt_(ctext).downcase
			
			rescue Exception => error

				raise error

			end


			ptext
		end


		protected

		def self.key_type
			@key_type
		end


		def self.expect_even_length_cyphertext?
			@expect_even_length_cyphertext
		end


		def self.plaintext_alphabet
			@plaintext_alphabet
		end


		def self.cyphertext_alphabet
			@cyphertext_alphabet
		end

	end


end