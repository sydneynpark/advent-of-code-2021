% Day 3
my_input = readmatrix("inputs\03input.txt", ...
    fixedWidthImportOptions('NumVariables', 12), ...
    "OutputType", "uint8");
my_input = logical(my_input)
num_inputs = length(my_input);

% Find the most common and uncommon bits at each position
common_bits = mean(my_input,1) >= 0.5;
uncommon_bits = ~ common_bits;

% Find decimal values and mutliply them together for the puzzle answer
gamma_rate = binary_vector_to_decimal(common_bits)
epsilon_rate = binary_vector_to_decimal(uncommon_bits)
power_consumption = gamma_rate * epsilon_rate

% Find rating values and multiply them together for the puzzle answer
oxygen_generator_rating = find_rating(my_input, true)
c02_scrubber_rating = find_rating(my_input, false)
life_support_rating = oxygen_generator_rating * c02_scrubber_rating


%% 
% 

function rating = find_rating(input_matrix, choose_popular)
    A = input_matrix;
    filter_position = 1;

    while length(A(:,1)) > 1

        % Count occurrences of each bit value at filter_position
        total_bits = length(A(:, filter_position));
        one_bits = sum(A(:, filter_position));
        zero_bits = total_bits - one_bits;
    
        % Determine which bit value to filter by
        bit_to_keep = (~choose_popular && one_bits < zero_bits) || ...
            (choose_popular && one_bits >= zero_bits);
        
        % Only matching values are candidates, all others are filtered out
        is_candidate = A(:, filter_position) == bit_to_keep;
        
        % Keep the values that were candidates to run through next time
        A = A(find(is_candidate),:);

        % Increment the bit position we will filter on
        filter_position = filter_position + 1;
    end

    % The last value left is the one we will return
    rating = binary_vector_to_decimal(A);
end


function decimal_number = binary_vector_to_decimal(binary_vector)
    binary_str = num2str(binary_vector);
    decimal_number = bin2dec(binary_str);
end