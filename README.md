# Single Substitution Monoalphabetic Cipher

## Deciphering the text of the first stage of the book -The Code Book- using frequency analysis with SHELL

After reading the book "The Code Book" by Simon Singh, I decided to decipher the present message of the first stage, at first it was a bit confusing because I didn't know if the final message would be in Portuguese or in English. But after applying the frequency analysis and seeing that the message still didn't make sense in English, I applied the frequency analysis in Portuguese.

There are several ways to decipher this code, including using other languages, so the way the text was deciphered here is just one of these possible ways.

Version 1.0
Using Shell scripting, in this version 1.0, the analysis of the frequency of the letters in a crude form is applied, changing all those that are more frequent in the ciphertext by the most frequent ones in a text in Portuguese.
More information on letter frequency by language https://en.wikipedia.org/wiki/Letter_frequency

Version 1.1
The letters "A" and "E" have the highest frequency rates in a text in Portuguese, so we have to make sure they are in the right position, as they influence the understanding of the text as a whole, for this reason I used the word "que" in this version, which is the most frequent 3-letter word in a Portuguese text (in addition to containing one of the two most frequent letters, "E")
A possible duplicate of the word "que" (means "that" in English) is also eliminated, removing the word that may end with the letter "q" (since words ending in "q" are not frequent in Portuguese)
By the end of this version, we can be more certain of the positions of the letters "E", "A", "Q" and "U".

Version 1.2
After the word "que", the words "não" (no or not, in English) and "uma" (a or an, in English) are the most frequent in the Portuguese text, so they are used in this version to be more certain about the position of the letters "M" and "N".

Version 1.3
In this version the word "ha" (there is/are in English) is used to find and correct the position of the letter "H". To avoid replacing another correct word that contains only 2 letters and ends in "a", the following words are removed from the search: "da ", "ja", "la" and "na" (in English: of the, already, there, in the; respectively)

The idea of deciphering ciphertexts is very old. The goal has always been to reveal the hidden message in the text.
That said, the script created here aims to make the text as understandable as possible to humans.
Letters with low frequencies are not treated as they can end up messing up the text again.
Of course, many will be in the right position because of the consecutive changes made in versions 1.1, 1.2 and 1.3.
Still regarding these last versions, the letters that are validated are "A", "E", "O", "U", "Q" and "H", that is, almost 45% of a common text in Portuguese .
The script here should also work for any other text that was ciphered using Single Substitution Monoalphabetic Cipher. Remembering that the larger and more common to the Portuguese language the ciphertext is, the greater the chance of understanding the result.

## Additional Information

The ciphertext from the book is also in this repo, in case you want to try it.

## How to run the script

You just have to give a ciphertext file to the script as a parameter, as below:

./script.sh file.txt

The ciphertext must be in upper case, if your ciphertext is in lower case, you can convert it here:
https://convertcase.net/