require "prime.rb"


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#~~CypherTools:
#
#~~CypherTools is a collection of methods useful for processes related to encryption and
#~~decryption of text. These methods consist primarily of text manipulation.
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


module CypherTools 


	GARBAGE_CH = "q"
	ALPHABET_ARY = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z]
	ALPHABET_AND_DIGITS_ARY = %w[a b c d e f g h i j k l m n o p q r s t u v w x y z 0 1 2 3 4 5 6 7 8 9]

	
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Method: rand_alpha  #=>  String
	#
	#~~Description: rand_alpha returns a pseudorandomly selected lower case alphabetic 
	#~~character.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


	def self.rand_alpha
		ALPHABET_ARY.sample
	end


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Method: garbage_alpha(length)  #=>  String
	#
	#~~Description: garbage_alpha returns a pseudorandom string of length :length: of lower 
	#~~case alphabetic characters.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	def self.garbage_alpha(length)
		length.times.map {rand_alpha}.join	
	end
	

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Method: rand_alnum  #=>  String
	#
	#~~Description: rand_alnum returns a pseudorandomly selected lower case alphanumeric 
	#~~character.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	
	def self.rand_alnum
		ALPHABET_AND_DIGITS_ARY.sample
	end
	

	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Method: garbage_alnum(length)  #=>  String
	#
	#~~Description: garbage_alnum returns a pseudorandom string of length :length: of lower case  
	#~~alphanumeric characters.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	def self.garbage_alnum(length)
		length.times.map {rand_alnum}.join
	end


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Method: alnum(text)  #=>  String
	#
	#~~Description: alnum returns a copy of String :text: with non-alphabetic characters removed.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	def self.only_alpha(text)
		text.gsub(/[^a-zA-z]/, "")
	end

	
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Method: alnum(text)  #=>  String
	#
	#~~Description: alnum returns a copy of String :text: with non-alphanumeric characters 
	#~~removed.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


	def self.only_alnum(text)
		text.gsub /[^0-9A-Za-z]/, ""
	end


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Method: unique(text)  #=>  String
	#
	#~~Description: unique returns a String containing the unique characters of :text: in the 
	#~~order they appear.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	def self.unique(text)
		list = String.new
		text.each_char {|ch| if !list.include? ch then list << ch end}
		
		list 
	end


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Method: jumble_alpha #=> String
	#
	#~~Description: jumble_alpba returns a String containing the lower case letters of the
	#~~alphabet in a random order.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	def self.jumble_alpha
		ALPHABET_ARY.shuffle.join
	end


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Method: jumble_alpha #=> String
	#
	#~~Description: jumble_alpba returns a String containing the lower case letters of the 
	#~~alphabet and the digits 0-9 all in a random order.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	def self.jumble_alnum
		ALPHABET_AND_DIGITS_ARY.shuffle.join
	end


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Method: rand_perm(size) #=> Array
	#
	#~~Description: rand_perm returns an Array of length :size: containing the number from 0 up 
	#~~to :size: in random order.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	def self.rand_perm(size)
		Array(0...size).shuffle
	end


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Method: shift_alpha(alpha, shift)  #=>  String
	#
	#~~Description: shift_alpha returns character :alpha: shiftedd - as in a caesar shift - by
	#~~magnitude of Integer :shift:
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	

	def self.shift_alpha(alpha, shift)
		if ('a'..'z').include? alpha #alpha is lower
			aMag = 'a'.ord 				#aMag stores the ASCII encoding for 'a' if alpha is lower or 'A' if alpha is upper 
		elsif ('A'..'Z').include? alpha # alpha is capital
			aMag = 'A'.ord
		else
			raise ArgumentError, "character must be alphabetic" unless alpha =~ /a-z/
		end

		raise ArgumentError, "no implicit coercion of #{shift.class} to Integer" unless shift.is_a? Integer

		
		(((alpha.ord + shift - aMag) % 26) + aMag).chr
	end


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Method: caesar(text, shift_mag)  #=>  String
	#
	#~~Description: caesar returns a caesar-shift of magnitude :shift_mag: of :text:. 
	#~~:shift_mag: may be either an Integer or a character - i.e. an "a"-shift, "b"-shift, et.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	

	def self.caesar(text, shift_mag)
		newText = ""

		if shift_mag.is_a? String
			shift_num = shift_mag.downcase.ord - "a".ord 
		elsif shift_mag.is_a? Integer
			shift_num = shift_mag
		else 
			raise ArgumentError, "no implicit coercion of #{shift_mag.class} to String"
		end
		
		#shift_alpha will catch if characters of :text: are not all alphabetic

		text.each_char.map {|ch| newText << shift_alpha(ch, shift_num)}
		
		newText
	end


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Method: substitute(text, interval = 1, &rule) #=> String
	#
	#~~Description: Substitute employs :rule: (a lambda or block which expects a string and   
	#~~returns a string) to encrypt substrings of the interval into arbitrary subtstrings,  
	#~~which are assembled in order. Used for alphabetic substitutions.
	#
	#~~ E.g. substitute("helloworld", 2) {|str| str.reverse}   #=>   "ehllworodl"
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	def self.substitute(text, interval = 1, &rule)
		newText = ""

		text.each_char.each_slice(interval) {|chrs| newText << rule.call(chrs.join)}
		
		newText
	end


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Method: transpose(text, perm)  #=>  String
	#
	#~~Description: Transpose returns a rectangular transposition of :text:, in which the
	#~~columns are reordered according to the order in Array :perm:. :perm: must include all
	#~~integers between 0 and its length.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	def self.transpose(text, perm)

		unless text.is_a? String
			raise ArgumentError, "no implicit coercion of #{text.class} to String"
		end

		unless perm.is_a? Array 
			raise ArgumentError, "no implicit coercion of #{perm.class} to Array"
		end

		0.upto(perm.length-1) do |num|
			if perm.index(num).nil?
				raise ArgumentError, "permutation must include all positive integers less than its length"
			end
		end

		newText = ""
		rLen = perm.length		
		cLen = text.length / rLen

		0.upto(rLen-1) do |col| 
			0.upto(cLen-1) do |row| 
				newText << text[perm.index(col) + row*rLen]
			end
		end

		newText	
	end


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Method: transpose(text, perm)  #=>  String
	#
	#~~Description: Transpose returns an inverted rectangular transposition of :text:, in 
	#~~which the columns are ASSUMED TO HAVE BEEN reordered according to the order in Array  
	#~~:perm:. :perm: must include all integers between 0 and its length. nv_transpose
	#~~inverts the process from transpose.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	def self.inv_transpose(text, perm)

		unless text.is_a? String
			raise ArgumentError, "no implicit coercion of #{text.class} to String"
		end

		unless perm.is_a? Array 
			raise ArgumentError, "no implicit coercion of #{perm.class} to Array"
		end

		0.upto(perm.length-1) do |num|
			if perm.index(num).nil?
				raise ArgumentError, "permutation must include all positive integers less than its length"
			end
		end

		newText = ""
		cLen = text.length / perm.length

		0.upto(cLen-1) do |row| 
			perm.each do |col| 
				newText << text[col*cLen + row]
			end
		end

		newText
	end


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

			characters =  CypherTools.unique CypherTools.only_alpha phrase
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

			characters = CypherTools.unique CypherTools.only_alnum phrase
			entries = characters.downcase.chars
			
			CypherTools::ALPHABET_AND_DIGITS_ARY.each {|ch| if !entries.include?(ch) then entries << ch end}
			
			super(entries, WIDTH)
		end	

	end


	module Math

		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~coprime?(num1, num2) #=> true or false
		#
		#~~Returns true if Integers :num:1 and :num2: are coprime, and false otherwise.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


		def self.coprime?(num1, num2)
			factorlist1 = Prime.prime_division(num1)

			factorlist1.each do |pair|
				factor = pair.first
				if self.divides?(factor, num2) then return false end
			end

			true
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~divides?(divisor, number) #=> true or false
		#
		#~~Returns true if Integer :divisor: divides Integer :number:, and false otherwise.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def self.divides?(divisor, number)
			number % divisor == 0
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: mod_inv?(num, mod) #=> Integer
		#
		#~~Description: mod_inv returns the modular inverse of Integer :int: with modulus :mod:
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def self.mod_inv(int, mod)
			i = berlekamp(int, mod)
		end

		protected


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: berklekamp(r1, r2) #=> Integer
		#
		#~~Description: berlekamp returns the inverse of :r1: modulus :r2: by applying the
		#~~Berlekamp variation on the extended Euclidean algorithm
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def self.berlekamp(r1, r2, p1 = 1, p2 = 0)
			r3 = r1 % r2
			a = (r1 - r3) / r2
			p3 = p1 - a * p2 

			if r3 == 0
				p2
			else
				berlekamp(r2, r3, p2, p3)
			end
		end
	end

end










