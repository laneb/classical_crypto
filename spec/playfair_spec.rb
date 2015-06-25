require_relative "./general_cypher_spec.rb"

PLAYFAIR = ClassicalCrypto::Cyphers::Playfair

pTextsCtextsAndNewPtextsByKey = {
	
	"" => [
		%w[hello\ world KCQVMPYMQMAT helqloworldq]
	],

	"abcdefghijklmnopqrstuvwxyz" => [
		%w[hello\ world KCQVMPYMQMAT helqloworldq]
	],

	"zyxwvutsrqponmlkjihgfedcba" => [
		%w[hello\ world KCFLPNYMQMAT helqloworldq]
	],

	"playfairriafyalp" => [
		%w[hello\ world KGAORVVQGRBT helqloworldq]
	]

}

run_general_cypher_spec_for	PLAYFAIR,  
							pTextsCtextsAndNewPtextsByKey

run_alphabetic_only_spec_for PLAYFAIR