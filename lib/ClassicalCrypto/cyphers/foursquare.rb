require_relative "../utils.rb"
require_relative "./cypher.rb"





module ClassicalCrypto::Cyphers
	class FourSquare < Cypher

		include PureAlphabeticPlaintext

		require_relative "foursquare/foursquare_key.rb"

		set_key_type_to FourSquareKey

		protected

		def encode(ptext)			
			if ptext.length.even?
				filledPtext = String.new ptext
			else
				filledPtext = ptext + ClassicalCrypto::Utils::GARBAGE_CH
			end

			ctext = ClassicalCrypto::Utils::Text.substitute(filledPtext, 2) {|pair| key.table.sub_pair(pair)}

			ctext
		end

		def decode(ctext)
			raise ArgumentError, "cyphertext must be of even length" unless ctext.length.even?
			ptext = ClassicalCrypto::Utils::Text.substitute(ctext, 2) {|pair| key.table.backsub_pair(pair)}
		end


	end
end