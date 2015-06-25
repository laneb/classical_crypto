require_relative "../utils.rb"
require_relative "./cypher.rb"

module ClassicalCrypto::Cyphers
	class Affine < Cypher

		require_relative "affine/affine_key.rb"

		set_key_type_to AffineKey

		include PureAlphabeticPlaintext

		protected

		def encode(ptext)
			ctext = ClassicalCrypto::Utils::Text.substitute(ptext) {|ch| sub_char(ch)}

			ctext
		end	

		def decode(ctext)
			ptext = ClassicalCrypto::Utils::Text.substitute(ctext) {|ch| backsub_char(ch)}

			ptext
		end

		private

		def sub_char(ch)
			(((key.coeff * (ch.ord - 97) + key.const) % 26) + 97).chr
		end

		def backsub_char(ch)
			(((key.inv_coeff * ((ch.ord - 65) - key.const)) % 26) + 65).chr
		end

	end
end