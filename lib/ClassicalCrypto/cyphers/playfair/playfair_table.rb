require_relative "../../util/cyphertools.rb"

class Playfair
	class PlayfairTable < CypherTools::Tables::AlphaTable

		def sub_pair(pair)

			x1, y1, x2, y2 = *coord(pair[0]), *coord(pair[1])
			
			if x1 == x2
				entry(x1, shift_fw(y1)) + entry(x2, shift_fw(y2))
			elsif y1 == y2
				entry(shift_fw(x1), y1) + entry(shift_fw(x2), y2)
			else
				entry(x2, y1) + entry(x1, y2)
			end
		end


		def backsub_pair(pair)
			x1, y1, x2, y2 = *coord(pair[0].downcase), *coord(pair[1].downcase)
			
			if x1 == x2
				entry(x1, shift_back(y1)) + entry(x2, shift_back(y2))
			elsif y1 == y2
				entry(shift_back(x1), y1) + entry(shift_back(x2), y2)
			else
				entry(x2, y1) + entry(x1, y2)
			end
		end



		private

		def shift_fw(coord)
			(coord + 1) % 5
		end

		def shift_back(coord)
			(coord + 5 - 1) % 5
		end

	end
end