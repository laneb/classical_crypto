require_relative "../../util/cyphertools.rb"
require_relative "../cypher.rb"

class Adfgvx

	require_relative "adfgvx_table.rb"

	class AdfgvxKey < Cypher::Key
	
		attr_reader :table, :perm

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

			@table = AdfgvxTable.new(phrase)
			@perm = perm
			super(@table,  @perm)
		end


		def self.random
			permLen = 2*Random.rand( (MinPermLength/2)..(MaxPermLength/2) )

			phrase = CypherTools::Text.jumble_alnum		
			perm = CypherTools::Text.rand_perm permLen
			
			self.new(phrase, perm)
		end
	end
end