class ClassicalCypher
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Class: Key
	#~~Constructor: Key.new(key_part, )
	#
	#~~Description A "virtual" layout for the object which organizes key info for any cipher 
	#~~object. Each cipher is accompanied by some child of they key class which stores the data 
	#~~which is used to encrypt and/or decrypt.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	class Key

		attr_reader :data

		def initialize(*data)
			@data = data				
		end
	end
end