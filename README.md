# A Markdown Parser using Lex and Yacc

This is a simple parser for markdown designed using lex and yacc. Flex has been used for lexical analysis and bison for syntax parsing. The following tags have been implemented:
## 1. Paragraphs
The  &lt;p> and &lt;/p> tags can be used to enclose paragraphs to automatically indent the first line and insert a newline after the last line. A paragraph can be started with $ to prevent the inital indentation on the first line like so: <b>&lt;p>$ ...&lt;/p></b>
## 2. Line Breaks
