%{
#include <iostream>
using namespace std;

extern int yylex();
extern int line_no;
extern int token_count;

void yyerror(const char *s);
%}

%token WHOLE THEN LOOP OUTPUT
%token ID NUM
%token ASSIGN_OP SEMICOLON
%token LEFT_PAREN RIGHT_PAREN
%token LEFT_BRACE RIGHT_BRACE

%%

program
    : stmt_list
    ;

stmt_list
    : statement stmt_list
    | /* empty */
    ;

statement
    : declaration
    | assignment
    | condition
    | loop
    | output
    ;

declaration
    : WHOLE ID SEMICOLON
    ;

assignment
    : ID ASSIGN_OP expr SEMICOLON
    ;

condition
    : THEN LEFT_PAREN expr RIGHT_PAREN
      LEFT_BRACE stmt_list RIGHT_BRACE
    ;

loop
    : LOOP LEFT_PAREN expr RIGHT_PAREN
      LEFT_BRACE stmt_list RIGHT_BRACE
    ;

output
    : OUTPUT ID SEMICOLON
    ;

expr
    : ID
    | NUM
    ;

%%

void yyerror(const char *s)
{
    cout << "\n❌ SYNTAX ERROR at line " << line_no << endl;
    cout << "Total Tokens Scanned = " << token_count << endl;
    exit(0);
}

int main()
{
    cout << "Compiler Started...\n";
    yyparse();   // MUST be called
    cout << "\n✔ Parsing Successful\n";
    cout << "Total Tokens Scanned = " << token_count << endl;
    return 0;
}
