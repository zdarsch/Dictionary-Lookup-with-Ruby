# Dictionary-Lookup-with-Ruby
This repository contains some rather simple scripts  to  lookup words in russian dictionaries,  while browsing the web.

Tools are made up of a  text-file dictionary,   an index of headwords, a webrick local server and a bookmarklet  to query the dictionary.

Zalizniak's grammatical dictionary and Shvedova's defining dictionary are chosen as examples.

When the user selects a word (or only a part of it) and clicks the bookmarklet,   the server simply searches the index for headwords beginning with the selection and returns the corresponding articles.

But an entirely different approach is also considered. Using a specially built finite state automaton,  the server   determines the lemmas corresponding to the selected word form and  then searches for them in the index.
