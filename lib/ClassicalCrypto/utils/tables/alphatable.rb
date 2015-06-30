module ClassicalCrypto::Utils::Tables


	require_relative "lookuptable.rb"


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: AlphaTable
	#
	#~~Description: AlphaTable is a 5x5 LookUpTable whose 25 entries include A-Z (and only A-Z).
	#~~Since A-Z includes 26 letters, I and J are indexed together, as is common in Polybius
	#~~squares.
	#
	#~~Constructor: AlphaTable.new(phrase = "")
	#~~Table will be initialized by writing the contents of phrase from left to right, top to
	#~~bottom of the table, ignoring duplicate entries. J will be treated as a duplicate of I.
	#~~Then the remaining letters of the alphabet will be written in in the same manner.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	class AlphaTable < LookUpTable


		WIDTH = 5
		

		def initialize(phrase = "")

			unless phrase.is_a? String
				raise TypeError, "no implicit coercion of #{phrase.class} to String"
			end


			characters =  ClassicalCrypto::Utils::Text.unique ClassicalCrypto::Utils::Text.only_alpha phrase
			entries = characters.downcase.chars

			ClassicalCrypto::Utils::ALPHABET_ARY.each do |ch| 
				unless entries.include? ch
					entries << (String.new ch)
				end
			end

			entries.delete("j")
			entries[entries.index("i")] << "j"
			

			super(entries, WIDTH)
		end



		private


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: index(ch) #-> Integer
		#
		#~~Description: Returns the index of :ch: in the Array :@entries:, or nil if :ch: is not 
		#~~included in :@entries:. Overloaded to account for I,J occuring in the same entry.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def index(ch)
			index = nil

			@entries.each_with_index do |entry, idx| 
				if entry.include? ch then  
					index = idx
					break
				end
			end
				
			index
		end


	end


end