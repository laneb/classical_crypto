module CypherTools
	module Tables
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
	end
end