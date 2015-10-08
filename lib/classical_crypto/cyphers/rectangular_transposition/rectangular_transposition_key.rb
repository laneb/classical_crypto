class ClassicalCrypto::Cyphers::RectangularTransposition


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: RectangularTranspositionKey
	#
	#~~Description: RectangularTranspositionKey is a subclass of Key which stores key data for the
	#~~RectangularTransposition cypher. 
	#
	#~~Constructor: RectangularTranspositionKey.new(coefficient, constant)
	#~~Stores Integers :coefficient: and constant, which refer to the coefficient and
	#~~and constant of the RectangularTransposition substitution function. 
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	class RectangularTranspositionKey < Key


		attr_reader :perm, :period

		MaxPermLength = 16
		MinPermLength = 8

		def initialize(perm)
			unless perm.is_a? Array
				raise TypeError, "no implicit coercion of #{perm.class} to Array"
			end
			
			unless 0.upto(perm.length - 1).all? {|num| perm.include? num}
				raise ArgumentError, "permutation Array must include all nonzero integers less than its length"
			end

			@perm = perm
			@period = perm.length
			
			super perm
		end



		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: self.random #=> RectangularTranspositionKey
		#
		#~~Description: returns an RectangularTranspositionKey generated with random integer coefficient and
		#~~constant.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		
		def self.random
			permLength = rand MinPermLength..MaxPermLength		
			perm = ClassicalCrypto::Utils::Text.rand_perm permLength
			
			self.new perm
		end


	end


end