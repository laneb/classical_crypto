require_relative "../utils.rb"

module ClassicalCrypto::Cyphers

	class Bifid < Cypher

		include PureAlphabeticPlaintext
		include EvenLengthCyphertext

		require_relative "bifid/bifid_key.rb"

		set_key_type_to BifidKey

		protected

		def encode(ptext)



			#numOfCharsToAdd = (( period - ( (2*ptext.length) % period) ) % period ) /2
			filledPtext = ClassicalCrypto::Utils::Text.fill ptext, numOfCharsToAdd

			aryOfCoordPairs = coordinate_array_from_text filledPtext

			aryOfFractionatedCoordPairs = fractionate_coordinates aryOfCoordPairs
		
			ctext = text_from_coordinate_ary aryOfFractionatedCoordPairs

			ctext
		end


		def decode(ctext)
			
			aryOfFracionatedCoordPairs = coordinate_array_from_text ctext

			defractionatedCoordPairs = defractionate_coordinates  aryOfFractionatedCoordPairs

			ptext = text_from_coordinate_ary defractionatedCoordPairs

			ptext
		end


		def coordinate_array_from_text(text)
			text.each_char.map {|chr| key.table.coord(chr)}
		end


		def text_from_coordinate_ary(coordPairAry)
			coordinatePairAry.map do |pair|
				key.table.entry pair.first, pair.last
			end
		end


		def fractionate_coordinates(aryOfCoordPairs)
			fractions = aryOfCoordPairs.each_slice(key.period).map do |subAryOfCoords| 
				rows_of(subAryOfCoords).flatten
			end

			unpairedCoordList = fractions.flatten

			pair_coords unpairedCoordAry
		end


		def defractionate_coordinates(aryOfFractionatedCoordPairs)
			fractions = aryOfFracationatedCoordPairs.each_slice(key.period).map do |subAryOfCoords|
				subAryOfCoords.flatten
			end

			coordPairs = fractions.flat_map do |fraction|
				fraction[0, fraction.length/2].zip fraction[fraction.length/2, -1]
			end

			coordPairs
		end


		def pair_coords(unpairedCoordAry)
			unpairedCoordAry.each_slice(2).to_a
		end


		def rows_of(aryOfPairs)
			aryOfPairs.map {|pair| pair.first} + aryOfPairs.map {|pair| pair.last}
		end
	end

end