require_relative "./general_cypher_spec.rb"
require_relative "#{CYPHERDIR}/vigenere.rb"

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

run_general_cypher_spec_for	Vigenere, 
							pTextsCtextsAndNewPtextsByKey


run_alphabetic_only_spec_for Vigenere