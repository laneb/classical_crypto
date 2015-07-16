require_relative "../../utils.rb"
require_relative "../cypher.rb"

class ClassicalCrypto::Cyphers::Affine


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: AffineKey
	#
	#~~Description: AffineKey is a subclass of Key which stores key data for the
	#~~Affine cypher. 
	#
	#~~Constructor: AffineKey.new(coefficient, constant)
	#~~Stores Integers :coefficient: and constant, which refer to the coefficient and
	#~~and constant of the Affine substitution function. 
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	class AffineKey < Key

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
			@inv_coeff = ClassicalCrypto::Utils::Math.mod_inv(coeff, ALPHA_MODULUS)
			super(@coeff, @const)
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: self.random #=> AffineKey
		#
		#~~Description: returns an AffineKey generated with random integer coefficient and
		#~~constant.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def self.random
			
			coeff = ALPHA_MODULUS
			until ClassicalCrypto::Utils::Math.coprime? ALPHA_MODULUS, coeff do 
				coeff = rand(MAX_RAND_COEFF) 
			end
			
			const = rand(ALPHA_MODULUS)
			
			self.new(coeff, const)
		end

	end
end