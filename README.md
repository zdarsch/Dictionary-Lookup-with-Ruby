# Dictionary-Lookup-with-Ruby
This repositry contains  a simple tool  to  look up words in a dictionary,  while browsing the web. The  tool is made up of  a dictionary,   an index of headwords, a  lightweight local server and a bookmarklet.

The file "zal_dict.txt" is  the main part of Zalizniak's grammatical dictionary and doesn't include proper nouns. Zalizniak's dictionary, has a CC BY-NC  license ( <https://github.com/gramdict/zalizniak-2010>) and  was chosen to serve as an example of a real dictionary. 

When the user selects text  and clicks the bookmarklet,  the tool searches the index for headwords beginning with the selected text and returns the corresponding entries of the dictionary.

Russian text is full of inflected forms but it is their "dictionary form" (lemma) that we want to look up. When a word  is not in "dictionary form", the user may discard its ending, select the stem,  click the bookmarklet and  the tool will find a bunch of headwords (all of them starting with the stem), including the dictionary form. This trick works fine  most of the time. 

Obviously, when the greatest common prefix of a word  and its lemma happens to be a single character, the preceding trick is of no use. However,  the user can still  click  the bookmarlet without selecting any text and type the lemma in the dialog box that pops up.

How to install:
1) Keep "zal_server.rb", "zal_index.txt" and "zal_dict.txt" together in the same folder
2) Run the script "zal_server.rb"
3) Launch the browser
4) Drag and drop "zalizniak.URL" onto  the bookmarks toolbar.

The scripts in Ruby274 were  run using the Scite editor on Windows 10.
The browser was Firefox.

Licensing: "zal_dict.txt": CC-BY-NC; other files: MIT
