%{
#include "y.tab.h"  // Yacc에서 생성된 헤더 파일을 포함합니다.
%}

%%

[0-9]+      { yylval.dval = atof(yytext); return NUMBER; }  // 숫자를 인식하고 반환
"+"         { return PLUS; }                           // + 연산자
"-"         { return MINUS; }                          // - 연산자
"*"         { return MUL; }                            // * 연산자
"/"         { return DIV; }                            // / 연산자
"("         { return LBRACE; }                         // 여는 괄호
")"         { return RBRACE; }                         // 닫는 괄호
[ \t\n]     { /* 공백 및 줄 바꿈 무시 */ }
.           { printf("알 수 없는 문자: %s\n", yytext); }

%%

int yywrap() { return 1; }
