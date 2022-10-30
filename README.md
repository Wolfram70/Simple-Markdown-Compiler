# A Markdown Parser using Lex and Yacc

This is a simple parser for markdown designed using lex and yacc. Flex has been used for lexical analysis and bison for syntax parsing. The following tags have been implemented:
## 1. Paragraphs
The  &lt;p> and &lt;/p> tags can be used to enclose paragraphs to automatically indent the first line and insert a newline after the last line. A paragraph can be started with $ to prevent the inital indentation on the first line like so: <b>&lt;p>$ ...&lt;/p></b>
## 2. Line Breaks
Line breaks can be inserted in the middle of any string with the &lt;br> tag which inserts a new line when parsed.
## 3. Headings
Headings can be written using the # tag like <b>#{insert_heading_here}</b>. The heading when displayed in stdout is displayed completely in uppercase to indicate that it is a heading.
<b>Note:</b> Headings cannot be declared inside paragraphs or lists as that will result in syntax error.
