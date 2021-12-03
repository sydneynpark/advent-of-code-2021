% Day 2

my_input = readmatrix("inputs/02input.txt","Delimiter"," ", "OutputType","string");
directions = my_input(:,1);
num_moves = length(directions);
[actions, dirs] = arrayfun(@interpret_direction, directions);
magnitudes_nums = arrayfun(@str2double, my_input(:,2));

[ actions, dirs, magnitudes_nums ]

% [depth, horizontal]
impact_per_move = zeros(num_moves, 2);
for move = 1:num_moves
    impact_per_move(move, actions(move)) = magnitudes_nums(move) * dirs(move);
end

% [ change of depth, change of horizontal position ]
impact_per_move
% calculate [ final depth, final horizontal position ]
% then multiply to get puzzle answer
position = sum(impact_per_move,1);
position_product = prod(position)
% magnitude_nums = how much to move/aim by
% actions = 1 for up/down, 2 for forward
% dirs = positive or negative
% impact_per_move = [ aim change, position change ]

% how does aim adjust over time? (up/down instructions)
aim_change_per_turn = impact_per_move(:,1);
aim_over_time = cumsum(aim_change_per_turn);

% how does position adjust over time (forward instructions)
position_change_per_turn = impact_per_move(:,2);
position_over_time = cumsum(position_change_per_turn);

% how does depth change over time (aim * forward instructions)
depth_change_per_turn = position_change_per_turn .* aim_over_time;
depth_over_time = cumsum(depth_change_per_turn);

% calculate final depth and final position
% then multiply to get answer
final_depth = depth_over_time(end);
final_position = position_over_time(end);
final_answer = final_position * final_depth;

% format so that matlab doesn't print as scientific
format longG;
final_answer
%%
function [dimension, direction] = interpret_direction(direction_string)
    if direction_string == "forward"
        dimension = 2;
        direction = 1;
    else
        dimension = 1;
        if direction_string == "up"
            direction = -1;
        else
            direction = 1;
        end
    end
end