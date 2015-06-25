require_relative "../lib/ClassicalCrypto.rb"

def run_general_cypher_spec_for(cypherType, pTextCtextNewPtextByKey)


	RSpec.describe cypherType, "#encrypt" do
		pTextCtextNewPtextByKey.each do |sampleKeyData, samplePtextsCtextsNewPtexts|
			context "with key #{sampleKeyData.inspect}" do
				cyph = cypherType.new *sampleKeyData

				context "plaintext is empty" do
					it "should return an empty string" do
						expect(cyph.encrypt "").to eq ""
					end
				end

				samplePtextsCtextsNewPtexts.each do |samplePtext, sampleCtext, newSamplePtext|
					it "should return upper case text without whitepsace" do
						expect(cyph.encrypt samplePtext).not_to match /[\Wa-z]/
					end

					it "should encrypt #{samplePtext.inspect} to #{sampleCtext.inspect}" do
						expect(cyph.encrypt samplePtext).to eq sampleCtext
					end
				end
			end
		end
	end


	RSpec.describe cypherType, "#decrypt" do
		pTextCtextNewPtextByKey.each do |sampleKeyData, samplePtextsCtextsNewPtexts|
			context "with key #{sampleKeyData.inspect}" do
				cyph = cypherType.new *sampleKeyData

				context "plaintext is empty" do
					it "should return an empty string" do
						expect(cyph.decrypt "").to eq ""
					end
				end

				samplePtextsCtextsNewPtexts.each do |samplePtext, sampleCtext, newSamplePtext|
					it "should return lower case text without whitepsace" do
						expect(cyph.decrypt sampleCtext).not_to match /[\WA-Z]/
					end

					it "should encrypt #{sampleCtext.inspect} to #{newSamplePtext.inspect}" do
						expect(cyph.decrypt sampleCtext).to eq newSamplePtext
					end
				end
			end
		end
	end
end


def run_alphabetic_only_spec_for(cypherType)
	cyph = cypherType.random
	
	RSpec.describe cypherType, "#encrypt" do
		context "plaintext includes numbers" do
			it "should raise an ArgumentError" do
				expect {raise ArgumentError}.to raise_error ArgumentError
			end
		end
	end
end