module ClassicalCrypto::Utils

	module Text
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
		#~~Method: fill(str, numOfCharsToAdd)  #=>  String
		#
		#~~Description: fill returns str appended with :numOfCharsToAdd: pseudorandom characters
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def self.fill(str, numOfCharsToAdd)
			str + garbage_alnum(numOfCharsToAdd)
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: only_alpha(text)  #=>  String
		#
		#~~Description: alpha returns a copy of String :text: with non-alphabetic characters removed.
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
	end
end