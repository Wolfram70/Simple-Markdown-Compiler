%{
 #include <stdio.h>
 #include <string.h>
 #include <ctype.h>
 int yylex(void);
 void yyerror(char *);

 char* strupr(char* s)
 {
    char* tmp = s;

    for (;*tmp;++tmp) {
        *tmp = toupper((unsigned char) *tmp);
    }

    return s;
 }
%}
%union {
	char *str;
	int count;
}
%token STRING
%token OPENPARA CLOSEPARA NEWLINE STARTLIST ENDLIST STARTITEM STARTHEADING ENDHEADING

%type<str> STRING
%type<count> STARTITEM
%type<str> program
%type<str> expr
%type<str> string
%type<str> list
%type<str> listmed
%type<str> heading
%%

program:
	program expr {;}
	| expr {;}
	;

list:
	STARTLIST listmed ENDLIST {
		$$ = $2;
		printf("%s", $2);
		$$[0] = '\0';
	}
	;

listmed:
	STARTITEM string {
		$$ = $2;
		char temp[300];
		sprintf(temp, "%d. %s\n", $1, $2);
		$$ = temp;
	}
	| listmed STARTITEM string {
		char temp[300];
		sprintf(temp, "%s%d. %s\n", $1, $2, $3);
		$$ = temp;
	}
	;

expr:
	OPENPARA string CLOSEPARA {
		$$ = $2;
		if ($$[0] == '$')
		{
			printf("%s\n", ++$$);
		}
		else printf("\t%s\n", $$);
		$$[0] = '\0';
	}
	| OPENPARA expr CLOSEPARA {;}
	| list {;}
	| heading {;}
	;

heading:
	STARTHEADING string ENDHEADING {
		$$ = strupr($2);
		char temp[500];
		sprintf(temp, "\n%s\n", $$);
		$$ = temp;
		printf("%s", $$);
		$$[0] = '\0';
	}
	;

string:
	STRING {
		$$ = $1;
	}
	| string STRING {
		$$ = $1;
		strcat($$, $2);
	}
	| string NEWLINE {
		$$ = $1;
		strcat($$, "\n");
	}
	;
%%
void yyerror(char *s) 
{
 fprintf(stderr, "%s\n", s);
}
int main(void) 
{
 yyparse();
 return 0;
} 