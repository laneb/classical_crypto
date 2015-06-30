module ClassicalCrypto::Utils
	
	
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Module: Tables
	#
	#~~Description: Tables is a namespace for the tables used in various substitution cyphers.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	module Tables


		require_relative "tables/lookuptable.rb"
		require_relative "tables/alphatable.rb"
		require_relative "tables/alnumtable.rb"		


	end


end