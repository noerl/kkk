-module(kkk_poke).

-export([create/0]).


%% 2张梅花K 1张黑桃K
create() ->
	PokeList = lists:reverse(lists:flatten([[Num, Num] || Num <- lists:seq(1, 54)])),
	create(PokeList).


create(PokeList) ->
	create(PokeList, [{0, []}, {0, []}, {0, []}], []).
	

create([Poke|List], UnFinList, FinList) ->
	case UnFinList of
		[{L1, PL1}, {L2, PL2}] ->
			case rand:uniform(2) of
				1 -> 
					case L1 < 35 of
						true -> 
							create(List, [{L1+1, [Poke|PL1]}, {L2, PL2}], FinList);
						false ->
							[[Poke|PL1], List ++ PL2, FinList]
					end;
				2 -> 
					case L2 < 35 of
						true ->
							create(List, [{L1, PL1}, {L2+1, [Poke|PL2]}], FinList);
						false ->
							[List ++ PL1, [Poke|PL2], FinList]
					end
			end;
		[{L1, PL1}, {L2, PL2}, {L3, PL3}] ->
			case rand:uniform(3) of
				1 -> 
					case L1 < 35 of
						true -> 
							create(List, [{L1+1, [Poke|PL1]}, {L2, PL2}, {L3, PL3}], FinList);
						false ->
							create(List, [{L2, PL2}, {L3, PL3}], [Poke|PL1])
					end;
				2 ->
					case L2 < 35 of
						true -> 
							create(List, [{L1, PL1}, {L2+1, [Poke|PL2]}, {L3, PL3}], FinList);
						false ->
							create(List, [{L1, PL1}, {L3, PL3}], [Poke|PL2])
					end;
				3 ->
					case L3 < 35 of
						true -> 
							create(List, [{L1, PL1}, {L2, PL2}, {L3+1, [Poke|PL3]}], FinList);
						false ->
							create(List, [{L1, PL1}, {L2, PL2}], [Poke|PL3])
					end
			end
	end.
