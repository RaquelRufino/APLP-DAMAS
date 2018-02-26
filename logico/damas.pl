init(Matrix) :- Matrix = [["-"," ",1," ",2," ",3," ",4," ",5," ",6," ",7," ",8],
                         [1,"~","O","~","O","~","O","~","O"],
                         [2,"O","~","O","~","O","~","O","~"],
                         [3,"~","O","~","O","~","O","~","O"],
                         [4,"~","~","~","~","~","~","~","~"],
                         [5,"~","~","~","~","~","~","~","~"],
                         [6,"X","~","X","~","X","~","X","~"],
                         [7,"~","X","~","X","~","X","~","X"],
                         [8,"X","~","X","~","X","~","X","~"]].


showMatrix([]).
showMatrix([Head|Tail]) :- write(Head), nl, showMatrix(Tail).

verifyPosition(X, Y, M, N, Value, OldValue, Result) :- X == N, Y == M,
    Result = Value; 
    Result = OldValue.
