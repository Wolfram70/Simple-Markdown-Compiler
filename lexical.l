%option noyywrap
%option nounistd
%option noinput nounput

%{
#include <stdlib.h>
#include <string.h>
#include "grammar.tab.h"

int cnt = 0;
%}
%%
"<list>" {return STARTLIST;}
"</list>" {
	cnt = 0;
	return ENDLIST;
	}
"<si>" {
	cnt++;
	yylval.count = cnt;
	return STARTITEM;
	}
"<p>" {return OPENPARA;}
"</p>" {return CLOSEPARA;}
"<br>" {return NEWLINE;}
"#{" {return STARTHEADING;}
"}" {return ENDHEADING;}
[a-zA-Z0-9.:;$ \t]+ {yylval.str = strdup(yytext); return STRING;}
%% 
