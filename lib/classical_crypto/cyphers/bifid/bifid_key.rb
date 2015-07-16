class ClassicalCrypto::Cyphers::Bifid
	class BifidKey < Key

		attr_reader :table, :period

		def initialize(phrase, period)
			raise TypeError, "no implicit coercion of #{phrase.class} to String" unless phrase.is_a? String

			@table = ClassicalCrypto::Utils::Tables::AlphaTable.new phrase
            @period = period

			super phrase, period
		end

		def self.random
			self.new ClassicalCrypto::Utils::Text.jumble_alpha
		end
	end
end