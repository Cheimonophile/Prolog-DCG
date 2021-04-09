:- use_rendering(svgtree, [list(false)]).

%========================================
% Grammar Rules

expr(expr(TERM)) --> term(TERM).
expr(expr(TERM, ADD_OP, EXPR)) --> term(TERM), add_op(ADD_OP), expr(EXPR).
%expr(expr(TERM, EXPR1)) --> term(TERM), expr1(EXPR1).
%expr1(expr1(ADD_OP, TERM)) --> add_op(ADD_OP), term(TERM).
%expr1(expr1(ADD_OP, TERM, EXPR1)) --> add_op(ADD_OP), term(TERM), expr1(EXPR1).
%expr1(expr1()) --> [].

term(term(FACTOR)) --> factor(FACTOR).
term(term(FACTOR, MULT_OP, TERM)) --> factor(FACTOR), mult_op(MULT_OP), term(TERM).
%term(term(FACTOR, TERM1)) --> factor(FACTOR), term1(TERM1).
%term1(term1(MULT_OP, FACTOR)) --> mult_op(MULT_OP),  factor(FACTOR).
%term1(term1(MULT_OP, FACTOR, TERM1)) --> mult_op(MULT_OP),  factor(FACTOR), term1(TERM1).
%term1(term1()) --> [].

factor(factor(NUMBER)) --> number(NUMBER).
factor(factor(ID)) --> id(ID).
factor(factor('-', FACTOR)) --> ['-'], factor(FACTOR).
factor(factor('(', EXPR,')')) --> ['('], expr(EXPR), [')'].

add_op(add_op('-')) --> ['-'].
add_op(add_op('+')) --> ['+'].

mult_op(mult_op('*')) --> ['*'].
mult_op(mult_op('/')) --> ['/'].

number(number(NUMBER)) --> [NUMBER], {integer(NUMBER)}.
id(id(ID)) --> [ID], {atom(ID)}.

/** <examples>

?- phrase(expr(Tree), [number, +, number]).
?- phrase(expr(Tree), Sentence).
?- phrase(expr(Tree), [-, 2, *, 4, +, 8, *, '(', 16, -, 32, ')']).
?- phrase(expr(Tree), [slope, *, x, +, intercept]).

*/