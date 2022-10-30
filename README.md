# A Markdown Parser using Lex and Yacc

This is a simple parser for markdown designed using lex and yacc. Flex has been used for lexical analysis and bison for syntax parsing. The following tags have been implemented:
## 1. Paragraphs
The  &lt;p> and &lt;/p> tags can be used to enclose paragraphs to automatically indent the first line and insert a newline after the last line. A paragraph can be started with $ to prevent the inital indentation on the first line like so: <b>&lt;p>$ ...&lt;/p></b>
## 2. Line Breaks
Line breaks can be inserted in the middle of any string with the &lt;br> tag which inserts a new line when parsed.
## 3. Headings
Headings can be written using the # tag and enclosed by curly braces like <b>#{insert_heading_here}</b>. The heading when displayed in stdout is displayed completely in uppercase to indicate that it is a heading. <br>
<b>Note:</b> Headings cannot be declared inside paragraphs or lists as that will result in syntax error.
## 4. Lists
Lists can be declared with the &lt;list> and &lt;/list> tags. New items can be added with the &lt;si> tag inside a list. Whenever a new item is to being written, it should be started with &lt;si> to parse it as such. For example, <br>
<b>&lt;list>&lt;si> one &lt;si> two&lt;/list></b> will be parsed as: <br>
1. one 2. two
