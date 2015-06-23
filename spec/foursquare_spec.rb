require_relative "./general_cypher_spec.rb"
require_relative "#{CYPHERDIR}/foursquare.rb"

pTextsCtextsAndNewPtextsByKey = {
	["", ""] => [
		%w[hello\ world KCLLMYMTOA helloworld],
		%w[Well\ Paid\ Scientist ZBLLLEIDSCKDOSHTQT wellpaidscientistq]
	],

	["four", "square"] => [
		%w[hello\ world GUHGIYIPLS helloworld],
		%w[Well\ Paid\ Scientist ZQHGHREAQUGALODPNP wellpaidscientistq]
	]
}

run_general_cypher_spec_for	FourSquare, 
							pTextsCtextsAndNewPtextsByKey

run_alphabetic_only_spec_for FourSquare