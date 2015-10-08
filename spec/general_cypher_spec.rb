def run_general_cypher_spec_for(cypher_type, pTextCtextNewPtextByKey)


	RSpec.describe cypher_type do

		describe "#encrypt" do
			pTextCtextNewPtextByKey.each do |sampleKeyData, samplePtextsCtextsNewPtexts|
				context "with key #{sampleKeyData.inspect}" do
					cypher = cypher_type.new *sampleKeyData

					context "plaintext is empty" do
						it "should return an empty string" do
							expect(cypher.encrypt "").to eq ""
						end
					end

					samplePtextsCtextsNewPtexts.each do |samplePtext, sampleCtext, newSamplePtext|
						encrypted_text = cypher.encrypt samplePtext

						it "should encrypt #{samplePtext.inspect} to #{sampleCtext.inspect}" do
							expect(encrypted_text).to eq sampleCtext
						end
					end
				end
			end
		end


		describe "#decrypt" do
			pTextCtextNewPtextByKey.each do |sampleKeyData, samplePtextsCtextsNewPtexts|
				context "with key #{sampleKeyData.inspect}" do
					cypher = cypher_type.new *sampleKeyData
 
					context "plaintext is empty" do
						it "should return an empty string" do
							expect(cypher.decrypt "").to eq ""
						end
					end

					samplePtextsCtextsNewPtexts.each do |samplePtext, sampleCtext, newSamplePtext|
						decrypted_text = cypher.decrypt sampleCtext

						it "should encrypt #{sampleCtext.inspect} to #{newSamplePtext.inspect}" do
							expect(decrypted_text).to eq newSamplePtext
						end
					end
				end
			end
		end
	end
end

