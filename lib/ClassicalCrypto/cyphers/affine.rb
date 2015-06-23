require_relative "../util/cyphertools.rb"
require_relative "./cypher.rb"


class Affine < ClassicalCypher
	
	class AffineKey < ClassicalCypher::Key

		MAX_RAND_COEFF = 100
		ALPHA_MODULUS = 26

		attr_reader :coeff, :const, :inv_coeff

		def initialize(coeff, const)
			unless coeff.is_a? Integer 
				raise TypeError, "no implicit conversion of #{coeff.class} to Integer"
			end

			unless const.is_a? Integer
				raise TypeError, "no implicit conversion of #{const.class} to Integer"
			end
	 
			@coeff = coeff
			@const = const
			@inv_coeff = CypherTools::Math.mod_inv(coeff, ALPHA_MODULUS)
			super(@coeff, @const)
		end

		def self.random
			
			coeff = ALPHA_MODULUS
			until CypherTools::Math.coprime? ALPHA_MODULUS, coeff do 
				coeff = rand(MAX_RAND_COEFF) 
			end
			
			const = rand(ALPHA_MODULUS)
			
			self.new(coeff, const)
		end

	end

	set_key_type_to AffineKey

	include PureAlphabeticPlaintext

	protected

	def encode(ptext)
		ctext = CypherTools.substitute(ptext) {|ch| sub_char(ch)}

		ctext
	end	

	def decode(ctext)
		ptext = CypherTools.substitute(ctext) {|ch| backsub_char(ch)}

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