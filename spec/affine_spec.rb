require_relative "./general_cypher_spec.rb"
require_relative "#{CYPHERDIR}/affine.rb"

pTextsCtextsAndNewPtextsByKey = {
	[1, 0] => [
		%w[hello\ world HELLOWORLD helloworld]
	],

	[1, 5] => [
		%w[hello\ world MJQQTBTWQI helloworld]
	],

	[3, 10] => [
		%w[hello\ world FWRRAYAJRT helloworld]
	]

}

run_general_cypher_spec_for	Affine, 
							pTextsCtextsAndNewPtextsByKey

run_alphabetic_only_spec_for Affine