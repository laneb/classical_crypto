VIGENERE = ClassicalCrypto::Cyphers::Vigenere

pTextsCtextsAndNewPtextsByKey = {
	["aaaaa"] => [
		%w[helloworld HELLOWORLD helloworld],
	],

	["abc"] => [
		%w[helloworld HFNLPYOSND helloworld],
	],

	["lqnvaekfmn"] => [ 
		%w[helloworld SUYGOAYWXQ helloworld],
	]

}

run_general_cypher_spec_for	VIGENERE, 
							pTextsCtextsAndNewPtextsByKey
