%option noyywrap

%{
#include "now.tab.c"
#include <iostream>
using namespace std;

int line_no = 1;
int token_count = 0;
%}

LETTER  [a-zA-Z_]
DIGIT   [0-9]
ID      {LETTER}({LETTER}|{DIGIT})*
NUM     {DIGIT}+

%%

"whole"     { token_count++; return WHOLE; }
"then"      { token_count++; return THEN; }
"yum"       { token_count++; return LOOP; }
"woup"      { token_count++; return OUTPUT; }

"="         { token_count++; return ASSIGN_OP; }
";"         { token_count++; return SEMICOLON; }
"("         { token_count++; return LEFT_PAREN; }
")"         { token_count++; return RIGHT_PAREN; }
"{"         { token_count++; return LEFT_BRACE; }
"}"         { token_count++; return RIGHT_BRACE; }

{NUM}       { token_count++; return NUM; }
{ID}        { token_count++; return ID; }

[ \t\r]+    { }
\n          { line_no++; }

. {
    cout << "Lexical Error at line " << line_no
         << ": Invalid symbol '" << yytext << "'" << endl;
    exit(0);
}

%%
