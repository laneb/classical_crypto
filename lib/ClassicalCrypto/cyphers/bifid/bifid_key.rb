class ClassicalCrypto::Cyphers::Bifid
	class BifidKey < Key

		attr_reader :table

		def initialize(phrase)
			raise TypeError, "no implicit coercion of #{phrase.class} to String" unless phrase.is_a? String

			@table = ClassicalCrypto::Utils::Tables::AlphaTable.new phrase

			super table
		end

		def random
			self.new ClassicalCrypto::Utils::Text.jumble_alpha
		end
	end
end