ForceOrder(Array) {
    assoc_1 := {}
    for key, value in Array {
        assoc_1.Insert(Value, Key)

    }
    assoc_2 := {}
    for key, value in assoc_1 {
        assoc_2.Insert(Value, Key)

    }
    return assoc_2
}
