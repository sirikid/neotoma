-module(test_parse).
-include_lib("eunit/include/eunit.hrl").

parser_test() ->
    % so we don't have to copy test.peg to .eunit
    Data = "rule <- .+;",
    file:write_file("test_parser.peg", io_lib:fwrite("~s\n", [Data])),
    neotoma:file("test_parser.peg"),
    compile:file("test_parser.erl", []),
    try
        TestString =  [19990,30028,32,102,111,111],
        Result = test_parser:parse(TestString),
        ?assertEqual(6, length(Result)),
        StringResult = lists:flatten(io_lib:format("~ts", [Result])),
        ?assertEqual(TestString, StringResult)
    catch
        _:_  -> ?assert(false)
    end.

p_charclass_square_brackets_test() ->
    Data = "rule <- [][];",
    file:write_file("test_p_charclass_brackets.peg", io_lib:fwrite("~s\n", [Data])),
    neotoma:file("test_p_charclass_brackets.peg"),
    compile:file("test_p_charclass_brackets.erl", []),
    try
        TestString = "\[\]\]\[",
        Result = test_p_charclass_brackets:parse(TestString),
        ?assertEqual(4, length(Result)),
        StringResult = lists:flatten(io_lib:format("~ts", [Result])),
        ?assertEqual(TestString, StringResult)
    catch
        _:_  -> ?assert(false)
    end.
