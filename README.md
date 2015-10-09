# ClassicalCrypto

ClassicalCrypto is a gem for encrypting and decrypting text using classical cryptographic algorithms. Included are a variety of cyphers as well as utilities to generate random keys for each.

Note that all classical cyphers are long-since broken, so they are vulnerable to known probabilistic attacks. This module is not to be used for practical secrecy. It is for educational and novelty purposes only.

ClassicalCrypto currently implements:
ADFGVX
Affine
Bifid
Caesar
Four-Square
Playfair
Vigenere

Coming features: tools for probabilistic analysis of cyphertext.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ClassicalCrypto'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ClassicalCrypto


## Usage

e.g.,

include "vigenere"

cypher = Vigenere.new
plaintext = "HELLO WORLD"
cyphertext = cypher.encrypt(plaintext)
decoded_text = cypher.decrypt(cyphertext)

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/ClassicalCrypto.

