require_relative "../utils.rb"

module ClassicalCrypto::Cyphers

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: Bifid
	#
	#~~Description: Bifid is a subclass of Cypher which encrypts alphanumeric text 
	#~~according to the algorithm of the bifid cypher: https://en.wikipedia.org/wiki/Bifid_cipher
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	class Bifid < Cypher

		require_relative "bifid/bifid_key.rb"

		@key_type = BifidKey

		@plaintext_alphabet = "abcdefghijklmnopqrstuvwxyz"
		@cyphertext_alphabet = "abcdefghijklmnopqrstuvwxyz"

		protected

		def _encrypt_(ptext)

			arrayOfCoordinatePairs = coordinate_array_from_text ptext

			aryOfFractionatedCoordPairs = fractionate_coordinates aryOfCoordPairs
		
			ctext = text_from_coordinate_ary aryOfFractionatedCoordPairs

			ctext
		end


		def _decrypt_(ctext)

			if ctext.length.odd?  
				raise ArgumentError, "cyphertext must be of odd length"
			end
			
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
			coordinate_chunk_iterator = arrayOfCoordPairs.each_slice key.period
			
			sequential_fractionated_coordinates = coordinate_chunk_iterator.map do |coordinate_pair_subarray|
				coordinate_pair_subarray.map {|pair| pair.first} + coordinate_pair_subarray.map {|pair| pair.last}
			end


			pair_elements_of sequantial_fractionated_coordinates
		end


		def defractionate_coordinates(array_of_fractionated_coordinate_pairs)
			sequential_fractionated_coordinates = array_of_fractionated_coordinate_pairs.flatten

			sequential_fractionated_coordinate_chunk_iterator = sequential_fractionated_coordinates.each_slice 2*key.period

			coordPairs = sequential_fractionated_coordinate_chunk_iterator.map do |fraction|
				fraction[0, fraction.length/2].zip fraction[fraction.length/2, -1]
			end

			coordPairs
		end


		def pair_elements_of(unpairedCoordAry)
			unpairedCoordAry.each_slice(2).map
		end
	end

end