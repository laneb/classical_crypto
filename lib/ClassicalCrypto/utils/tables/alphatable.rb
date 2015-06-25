module ClassicalCrypto::Utils::Tables

	require_relative "lookuptable.rb"

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

		def index(ch)
			search = Proc.new {|entry, index| if entry.include? ch then return index end}
				@entries.each_with_index &search
			nil
		end
	end
end