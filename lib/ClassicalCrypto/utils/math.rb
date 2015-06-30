require "prime.rb"

module ClassicalCrypto::Utils


	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	#~~Module: Cyphers
	#
	#~~Description: Math is a namespace including all math-related utility methods.
	#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

	module Math


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: self.coprime?(num1, num2) #=> true or false
		#
		#~~Description: Returns true if Integers :num:1 and :num2: are coprime, and false otherwise.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def self.coprime?(num1, num2)
			numsShareFactor = false


			factorlist1 = Prime.prime_division(num1)

			factorlist1.each do |pair|
				factor = pair.first
				if self.divides?(factor, num2) 
					numsShareFactor = true
					break
				end
			end


			!numsShareFactor
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: self.divides?(divisor, number) #=> true or false
		#
		#~~Description: Returns true if Integer :divisor: divides Integer :number:, and false otherwise.
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def self.divides?(divisor, number)
			number % divisor == 0
		end


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: self.mod_inv?(num, mod) #=> Integer
		#
		#~~Description: mod_inv returns the modular inverse of Integer :int: with modulus :mod:
		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

		def self.mod_inv(int, mod)
			i = berlekamp(int, mod)
		end

		protected


		#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		#~~Method: self.berklekamp(r1, r2) #=> Integer
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