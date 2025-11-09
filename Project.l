%{
#include <iostream>
#include <string>
using namespace std;

int line_count = 1;
int token_count = 0;
%}

%option noyywrap

%%

\/\*([^\*]|\*[^/])*\*\/   { token_count++; cout << "Line " << line_count << " | Token " << token_count << " -> COMMENT (multi-line): " << yytext << endl; }
\/\/[^\n]*                { token_count++; cout << "Line " << line_count << " | Token " << token_count << " -> COMMENT (single-line): " << yytext << endl; }

"func"|"num"|"txt"|"booll"|"arr"|"charac"|"struc"|"decil" { token_count++; cout << "Line " << line_count << " | Token " << token_count << " -> DATATYPE: " << yytext << endl; }

"mazeed"|"rukain"|"dikhain"|"shyd"|"tou"|"jab"|"wapis"|"ilfaz"|"ginti"|"wakya"|"alag"|"dein"|"aur"|"nahi"|"han" {
    token_count++;
    cout << "Line " << line_count << " | Token " << token_count << " -> KEYWORD: " << yytext << endl;
}

\]|~|%                     { token_count++; cout << "Line " << line_count << " | Token " << token_count << " -> OPERATOR: " << yytext << endl; }

:                          { token_count++; cout << "Line " << line_count << " | Token " << token_count << " -> PUNCTUATION (colon): " << yytext << endl; }
-                          { token_count++; cout << "Line " << line_count << " | Token " << token_count << " -> PUNCTUATION (dash): " << yytext << endl; }

[0-9]+\.[0-9]+             { token_count++; cout << "Line " << line_count << " | Token " << token_count << " -> FLOAT: " << yytext << endl; }
[0-9]+                     { token_count++; cout << "Line " << line_count << " | Token " << token_count << " -> INTEGER: " << yytext << endl; }

"`"([^`\n]*)"`"             { token_count++; cout << "Line " << line_count << " | Token " << token_count << " -> STRING: " << yytext << endl; }
\|[^|\n]\|                  { token_count++; cout << "Line " << line_count << " | Token " << token_count << " -> CHARACTER: " << yytext << endl; }

@([A-Za-z_][A-Za-z0-9_]*)   { token_count++; cout << "Line " << line_count << " | Token " << token_count << " -> IDENTIFIER: " << yytext << endl; }

[ \t\r]+                    { /* skip whitespace */ }
\n                          { line_count++; }
.                           { /* ignore any other character */ }

%%

int main() {
    cout << "\n----- Lexical Analyzer -----\n";
    cout << "Starting lexical scan...\n\n";

    yylex();

    cout << "\n----------------------------------\n";
    cout << "Total Tokens: " << token_count << endl;
    cout << "Total Lines: " << line_count << endl;
    cout << "----------------------------------\n";

    return 0;
}
