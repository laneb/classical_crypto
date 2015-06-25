require_relative "../../utils.rb"

class ClassicalCrypto::Cyphers::FourSquare
	class FourSquareTable

		ALPHA = ClassicalCrypto::Utils::Tables::AlphaTable.new

		def initialize(phrase1, phrase2)
			@code_table1 = ClassicalCrypto::Utils::Tables::AlphaTable.new(phrase1)
			@code_table2 = ClassicalCrypto::Utils::Tables::AlphaTable.new(phrase2)
		end


		def sub_pair(pair)
			ch1, ch2 = pair[0], pair[1]
			x1, y1, x2, y2 = *ALPHA.coord(ch1), *ALPHA.coord(ch2)
			@code_table1.entry(x2, y1) + @code_table2.entry(x1, y2)
		end


		def backsub_pair(pair)
			ch1, ch2 = pair[0].downcase, pair[1].downcase

			x1, y1, x2, y2 = *@code_table1.coord(ch1), *@code_table2.coord(ch2)
			ALPHA.entry(x2, y1) + ALPHA.entry(x1, y2)
		end

	end
end