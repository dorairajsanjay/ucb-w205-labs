trim () {
    read -rd '' $1 <<<"${!1}"
}

test=" test "
test1=trim $test 

echo $test1 > temp.txt
