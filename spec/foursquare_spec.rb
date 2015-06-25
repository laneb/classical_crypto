require_relative "./general_cypher_spec.rb"

FOURSQUARE = ClassicalCrypto::Cyphers::FourSquare

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

run_general_cypher_spec_for	FOURSQUARE, 
							pTextsCtextsAndNewPtextsByKey

run_alphabetic_only_spec_for FOURSQUARE