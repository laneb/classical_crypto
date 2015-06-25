class Cypher
	module PureAlphabeticPlaintext

		def encrypt(ptext)
			if ptext.match /\d/ then raise ArgumentError, "plaintext may not include numbers" end

			encode(CypherTools::Text.only_alpha(ptext.downcase)).upcase
		end 

	end
end