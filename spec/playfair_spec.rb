PLAYFAIR = ClassicalCrypto::Cyphers::Playfair

pTextsCtextsAndNewPtextsByKey = {
	
	[""] => [
		%w[helloworld KCQVMPYMQMAT helqloworldq]
	],

	["abcdefghijklmnopqrstuvwxyz"] => [
		%w[helloworld KCQVMPYMQMAT helqloworldq]
	],

	["zyxwvutsrqponmlkjihgfedcba"] => [
		%w[helloworld KCFLPNYMQMAT helqloworldq]
	],

	["playfairriafyalp"] => [
		%w[helloworld KGAORVVQGRBT helqloworldq]
	]

}

run_general_cypher_spec_for	PLAYFAIR,  
							pTextsCtextsAndNewPtextsByKey

