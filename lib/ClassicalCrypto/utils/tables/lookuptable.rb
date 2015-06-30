module ClassicalCrypto::Utils::Tables



	protected


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: LookUpTable
	#
	#~~Description: An indexed rectangular table which provides methods to read from
	#~~entries according to their indices and to find the index of entries according to their 
	#~~values. LookUpTable is the backbone of the tables used in cyphers like ADFGVX and Playfair
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
				raise TypeError, "no implicit coercion of #{width.class} to Integer" 
			end
			
			unless ClassicalCrypto::Utils::Math.divides? width, entries.length
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


end