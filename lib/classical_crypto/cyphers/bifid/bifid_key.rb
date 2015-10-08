class ClassicalCrypto::Cyphers::Bifid
	class BifidKey < Key

		MIN_PERIOD_LENGTH = 12
		MAX_PERIOD_LENGTH = 16

		attr_reader :table, :period

		def initialize(phrase, period)
			raise TypeError, "no implicit coercion of #{phrase.class} to String" unless phrase.is_a? String

			@table = ClassicalCrypto::Utils::Tables::AlphaTable.new phrase
            @period = period

			super phrase, period
		end

		def self.random
			rand_phrase = ClassicalCrypto::Utils::Text.jumble_alpha

			rand_period = MIN_PERIOD_LENGTH + Random.rand(MAX_PERIOD_LENGTH - MIN_PERIOD_LENGTH)
			
			self.new rand_phrase, rand_period
		end
	end
end