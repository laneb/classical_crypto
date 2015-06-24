require_relative "../../util/cyphertools.rb"
require_relative "../cypher.rb"

class Affine
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
end