module CypherTools

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: LookUpTable
	#
	#~~Description: An indexed rectangular table which provides methods both to read from
	#~~according to their indices and to find the index of entries according to their 
	#~~values. LookUpTable is the backbone of the substitution tables for the Adfgvx, 
	#~~Playfair, and Foursquare ciphers
	#
	#~~Constructor: LookUpTable.new(entries, width)
	#~~Array :entries: specifies the entries which will fill the table. Integer :width:   
	#~~specifies the number of columns in the table. :width: must divide the length of 
	#~~:entries:. Entries will be filled into table left to right and wrap down.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


	class LookUpTable

		attr_reader :width, :height

		def initialize(entries, width)

			unless entries.is_a? Array
				raise TypeError, "no implicit coercion of #{entries.class} to Array" 
			end
			
			unless width.is_a? Integer
				raise TypeError, "no implicit coercion of #{entries.inspect}:#{entries.class} to Integer" 
			end
			
			unless CypherTools::Math.divides? width, entries.length
				raise ArgumentError, "#{width} does not divide length #{entries.length} of Array #{entries.inspect}" 
			end

			@entries, @width, @height = entries, width, entries.length / width
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: get_row(row)  #=>  Array
		#
		#~~Description: get_row returns the :row:th row of the table.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	

		def get_row(row)
			@entries[row*@width, @width]
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: get_col(col)  #=>  Array
		#
		#~~Description: get_col returns the :col:th column of the table.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	

		def get_col(col)
			0.upto(@height).map {|row| @entries[row*@width+col]}
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: entry(col, row)  #=>  Array
		#
		#~~Description: entry returns the entry in the :col:th column and the :row:th row of the
		#~~table.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~		

		def entry(x, y)
			@entries[y*@width + x][0]
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: coord(entry)  #=>  Array
		#
		#~~Description: coord returns the coordinate of :entry: if it is in the table, and nil
		#~~otherwise.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	

		def coord(entryToFind)
			idx = index(entryToFind)

			if idx.nil?
				nil
			else
				[idx % @width, idx / @width]
			end
		end


		private

		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: index(entry)  #=>  Array
		#
		#~~Description: index returns the 1-dimensional index of the entry. 
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	

		def index(entryToFind)
			@entries.index(entryToFind)
		end

	end


	class AlphaTable < LookUpTable

		WIDTH = 5

		def initialize(phrase = "")

			unless phrase.is_a? String
				raise TypeError, "no implicit coercion of #{phrase.class} to String"
			end

			characters =  CypherTools::Text.unique CypherTools::Text.only_alpha phrase
			entries = characters.downcase.chars

			CypherTools::ALPHABET_ARY.each do |ch| 
				unless entries.include? ch
					entries << (String.new ch)
				end
			end

			entries.delete("j")

			entries[entries.index("i")] << "j"
			


			super(entries, WIDTH)
		end

		private

		def index(ch)
			search = Proc.new {|entry, index| if entry.include? ch then return index end}
				@entries.each_with_index &search
			nil
		end
	end


	class AlnumTable < LookUpTable

		WIDTH = 6


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~initialize(str)
		#
		#~~initialize creates the array of characters @entries used to simulate the ADFGVX table.
		#~~@entries will always be initialized to include all 26 lower case alphabetical characters
		#~~and 10 digits.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		
		def initialize(phrase = "")
			unless phrase.is_a? String
				raise TypeError, "no implicit coercion of #{phrase.class} to String"
			end

			characters = CypherTools::Text.unique CypherTools::Text.only_alnum phrase
			entries = characters.downcase.chars
			
			CypherTools::ALPHABET_AND_DIGITS_ARY.each {|ch| if !entries.include?(ch) then entries << ch end}
			
			super(entries, WIDTH)
		end	

	end
end