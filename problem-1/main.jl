function input(prompt::AbstractString="")
    print(prompt)
    return parse(Int64, chomp(readline()))
end

function input_special(prompt::AbstractString="")
    print(prompt)
    s = split(chomp(readline()), ",")
    return parse.(Int64, s)
end

weights = []
values = []
num_items = input("Enter number of items: ")
for i in 1:num_items
    r = input_special("Enter weight and value comma separated for item $i: ")
    append!(weights, r[1])
    append!(values, r[2])
end
# values = [8, 7, 12, 6, 2, 3]
# weights = [5, 6, 10, 4, 1, 1]
ks_solution_weights = []
ks_solution_values = []
ks_max_weight = input("Enter limit of the collection: ")#16

function calculate_heuristic(arr)
    # Returns sum of values
    if size(arr)[1] < 1
        return 0
    end
    return sum(arr)
end
function get_ks_weight()
    if size(ks_solution_weights)[1] < 1
        return 0
    end
    return sum(ks_solution_weights)
end

for step in 1:size(values)[1]
    current_heuristic = calculate_heuristic(ks_solution_values)
    heuristic_index = -1
    for j in 1:size(values)[1]
        # Don't attempt on item which will make sack over limit weight if added
        if get_ks_weight() + weights[j] <= ks_max_weight
            # Pretend to add item to sack and get heuristic(value) with newly added item
            temp_sack = deepcopy(ks_solution_values)
            append!(temp_sack, values[j])
            
            temp_heuristic = calculate_heuristic(temp_sack)
            if temp_heuristic > current_heuristic
                # New heuristic
                heuristic_index = j
                current_heuristic = temp_heuristic
            end
        end
    end
    # Add item with highest heuristic in current iteration to sack
    if heuristic_index != -1
        # Remove from values and weights from array to avoid duplicate processing in next iteration
        # Weight
        _weight = weights[heuristic_index]
        append!(ks_solution_weights, _weight)
        deleteat!(weights, heuristic_index)
        # Value
        _value = values[heuristic_index]
        append!(ks_solution_values, _value)
        deleteat!(values, heuristic_index)
        
        println(
            "Step => ",
            step,
            ", Current heuristic => ",
            calculate_heuristic(ks_solution_values),
            ", Sack weight => ",
            get_ks_weight(),
        )
    end
end
println()
println("Remaining weight in knapsack => ", ks_max_weight-get_ks_weight())
println("Final heuristic => ", calculate_heuristic(ks_solution_values))
println()
println("Combination of solution:")
for i in 1:size(ks_solution_values)[1]
    println("Item Value => ",ks_solution_values[i]," Weight => ", ks_solution_weights[i])
end
