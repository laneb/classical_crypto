require_relative "./general_cypher_spec.rb"

VIGENERE = ClassicalCrypto::Cyphers::Vigenere

pTextsCtextsAndNewPtextsByKey = {
	"aaaaa" => [
		%w[hello\ world HELLOWORLD helloworld],
	],

	"abc" => [
		%w[hello\ world HFNLPYOSND helloworld],
	],

	"lqnvaekfmn" => [ 
		%w[hello\ world SUYGOAYWXQ helloworld],
	]

}

run_general_cypher_spec_for	VIGENERE, 
							pTextsCtextsAndNewPtextsByKey


run_alphabetic_only_spec_for VIGENERE