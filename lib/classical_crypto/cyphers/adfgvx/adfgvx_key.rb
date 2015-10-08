require_relative "../../utils.rb"
require_relative "../cypher.rb"

class ClassicalCrypto::Cyphers::Adfgvx

	require_relative "adfgvx_table.rb"


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: AdfgvxKey
	#
	#~~Description: AdfgvxKey is a subclass of Key which stores key data for the
	#~~Adfgvx cypher. 
	#
	#~~Constructor: AdfgvxKey.new(phrase, perumtation)
	#~~Initializes an AlnumTable with String :phrase: and stores Array of Integers permutation,
	#~~which specifies the column order for the transposition and must contain the integers
	#~~betweeen 0 and its length (and only those integers).
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	class AdfgvxKey < Key
	
		attr_reader :table, :perm, :period

		MaxPermLength = 16
		MinPermLength = 8

		def initialize(phrase, perm)
			unless phrase.is_a? String
				raise TypeError, "no implicit conversion of #{phrase.class} to String"
			end

			unless perm.is_a? Array
				raise TypeError, "no implicit conversion of #{perm.class} to Array"
			end

			unless perm.length.even?
				raise ArgumentError, "permutation Array must be of even length"
			end

			unless 0.upto(perm.length - 1).all? {|num| perm.include? num}
				raise ArgumentError, "permutation Array must include all nonzero integers less than its length"
			end


			@table = AdfgvxTable.new(phrase)
			@perm = perm
			@period = perm.length

			super(phrase,  perm)
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: self.random #=> AdfgvxKey
		#
		#~~Description: returns an AdfgvxKey generated with randomly ordered permutation Array
		#~~of random length betweeen 8 and 16 and and randomly orddered alphabet.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def self.random
			permLen = 2*Random.rand( (MinPermLength/2)..(MaxPermLength/2) )

			phrase = ClassicalCrypto::Utils::Text.jumble_alnum		
			perm = ClassicalCrypto::Utils::Text.rand_perm permLen
			
			self.new(phrase, perm)
		end
	end
end