mutable struct Node
    value::Any
    children::Array{Any,1}
end

function get_max(a1, a2)
    if typeof(a1) == UndefInitializer
        return a2
    end
    if typeof(a2) == UndefInitializer
        return a1
    end
    return max(a1, a2)
end

function get_min(a1, a2)
   if typeof(a1) == UndefInitializer
        return a2
    end
    if typeof(a2) == UndefInitializer
        return a1
    end
    return min(a1, a2)
end

function minimax(node, is_maximize)
    # Check if is leaf
    if isempty(node.children)
        return node.value
    end
    if is_maximize
        max_val = -Inf
        for child_index in 1:size(node.children)[1]
            # Should perform minimization
            val = minimax(node.children[child_index], false)
            # Update maximum
            max_val = get_max(max_val, val)
        end
        return max_val
    else
        min_val = Inf
        for child_index in 1:size(node.children)[1]
            val = minimax(node.children[child_index], true)
            min_val = get_min(min_val, val)
        end
        return min_val
    end
end

leaf1 = Node(3, [])
leaf2 = Node(5, [])
leaf3 = Node(10, [])
n1 = Node(undef, [leaf1, leaf2, leaf3])

leaf11 = Node(2, [])
leaf21 = Node(8, [])
leaf31 = Node(19, [])
n2 = Node(undef, [leaf11, leaf21, leaf31])

leaf12 = Node(2, [])
leaf22 = Node(7, [])
leaf32 = Node(3, [])
n3 = Node(undef, [leaf12, leaf22, leaf32])

rootNode = Node(undef, [n1, n2, n3])
println(minimax(rootNode, true))
