require_relative "./general_cypher_spec.rb"

AFFINE = ClassicalCrypto::Cyphers::Affine

pTextsCtextsAndNewPtextsByKey = {
	[1, 0] => [
		%w[helloworld HELLOWORLD helloworld]
	],

	[1, 5] => [
		%w[helloworld MJQQTBTWQI helloworld]
	],

	[3, 10] => [
		%w[helloworld FWRRAYAJRT helloworld]
	]

}

run_general_cypher_spec_for	AFFINE, 
							pTextsCtextsAndNewPtextsByKey

