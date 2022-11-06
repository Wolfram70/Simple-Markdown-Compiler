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
%token OPENPARA CLOSEPARA
%token STARTLIST ENDLIST STARTHEADING ENDHEADING
%token STARTITEM
%token NEWLINE

%right OPENPARA
%left CLOSEPARA
%nonassoc STARTLIST ENDLIST

%start program

%type<str> STRING
%type<count> STARTITEM
%type<str> program
%type<str> expr
%type<str> string
%type<str> list
%type<str> listmed
%type<str> heading
%%

list:
	STARTLIST listmed ENDLIST {
		$$ = $2;
	}
	;

listmed:
	STARTITEM string {
		$$ = $2;
		char temp[5000];
		sprintf(temp, "%d. %s\n", $1, $2);
		$$ = temp;
	}
	| listmed STARTITEM string {
		char temp[5000];
		sprintf(temp, "%s%d. %s\n", $1, $2, $3);
		$$ = temp;
	}
	;

expr:
	OPENPARA string CLOSEPARA {
		$$ = $2;
		char temp[5000];
		if ($$[0] == '$')
		{
			sprintf(temp, "%s\n", ++$$);
		}
		else sprintf(temp, "\t%s\n", $$);
		$$ = temp;
	}
	| OPENPARA expr CLOSEPARA {
		$$ = $2;
		char temp[5000];
		sprintf(temp, "\t%s\n", $$);
		$$ = temp;
	}
	| string expr {
		$$ = $1;
		strcat($$, "\n");
		strcat($$, $2);
	}
	| list {
		$$ = $1;
	}
	| heading {
		$$ = $1;
	}
	;

heading:
	STARTHEADING string ENDHEADING {
		$$ = strupr($2);
		char temp[5000];
		sprintf(temp, "\n%s\n", $$);
		$$ = temp;
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
program:
	program expr {
		printf("%s", $2);
	}
	| expr {
		printf("%s", $1);
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