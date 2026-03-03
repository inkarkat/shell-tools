#!/usr/bin/env bats

load fixture

@test "second passed custom candidate is executed with custom arguments appended" {
    run -0 withFirstCallableCommand --custom-candidate doesNotExist \; --custom-candidate commandAlpha 'apple pie' apricot asparagus avocado \; --custom-candidate commandBeta blueberry \;
    assert_output 'alpha-apple pie-apricot-asparagus-avocado'
}

@test "second passed custom candidate is executed with custom arguments appended to common arguments" {
    run -0 withFirstCallableCommand --custom-candidate doesNotExist \; --custom-candidate commandAlpha 'apple pie' apricot asparagus avocado \; --custom-candidate commandBeta blueberry \; one two 'and three'
    assert_output 'alpha-one-two-and three-apple pie-apricot-asparagus-avocado'
}

@test "second passed custom candidate is executed with custom arguments inserted at marker {@}" {
    run -0 withFirstCallableCommand --custom-candidate doesNotExist \; --custom-candidate commandAlpha 'apple pie' apricot asparagus avocado \; --custom-candidate commandBeta blueberry \; one two {@} 'and three'
    assert_output 'alpha-one-two-apple pie-apricot-asparagus-avocado-and three'
}

@test "second passed custom candidate is executed by wrapper with custom arguments inserted at marker {@}" {
    run -0 withFirstCallableCommand --custom-candidate doesNotExist \; --custom-candidate commandAlpha 'apple pie' apricot asparagus avocado \; --custom-candidate commandBeta blueberry \; wrapper {} one two '{@}' 'and three'
    assert_output '[alpha-one-two-apple pie-apricot-asparagus-avocado-and three]'
}

@test "custom arguments are inserted at individual markers" {
    run -0 withFirstCallableCommand --custom-candidate commandAlpha 'apple pie' apricot asparagus avocado \; one '{1}' two '{2}' 'and three' '{3}' 'and four' '{4}'
    assert_output 'alpha-one-apple pie-two-apricot-and three-asparagus-and four-avocado'
}

@test "custom arguments are inserted at individual markers with negative indices" {
    run -0 withFirstCallableCommand --custom-candidate commandAlpha 'apple pie' apricot asparagus avocado \; one '{-4}' two '{-3}' 'and three' '{-2}' 'and four' '{-1}'
    assert_output 'alpha-one-apple pie-two-apricot-and three-asparagus-and four-avocado'
}

@test "custom arguments are inserted at markers mixed with other text" {
    run -0 withFirstCallableCommand --custom-candidate commandAlpha 'apple pie' apricot asparagus avocado \; 'favorite: {1}' 'I also like {2}' '"{-2}" I cannot even spell correctly'
    assert_output 'alpha-favorite: apple pie-I also like apricot-"asparagus" I cannot even spell correctly'
}

@test "custom arguments are inserted at individual mixed and duplicate markers" {
    run -0 withFirstCallableCommand --custom-candidate commandAlpha 'apple pie' apricot asparagus avocado \; take from '{@}:' one '"{1}"' 'two or three {2}' '{-1} or {-2}' '{3} {4} or {4} {3}'
    assert_output 'alpha-take-from-apple pie-apricot-asparagus-avocado:-one-"apple pie"-two or three apricot-avocado or asparagus-asparagus avocado or avocado asparagus'
}

@test "non-markers are ignored" {
    run -0 withFirstCallableCommand --custom-candidate commandAlpha 'apple pie' apricot asparagus avocado \; one '{1}' two '{X}' three '{*}' 'more {+7}' 'final {-1}'
    assert_output 'alpha-one-apple pie-two-{X}-three-{*}-more {+7}-final avocado'
}

@test "markers beyond the number of custom arguments resolve to empty string" {
    run -0 withFirstCallableCommand --custom-candidate commandAlpha 'apple pie' apricot asparagus avocado \; one '{1}' five '{5}' 'fifth from behind' '{-5}' two '{2}'
    assert_output 'alpha-one-apple pie-five--fifth from behind--two-apricot'
}

@test "dual-digit markers work" {
    run -0 withFirstCallableCommand --custom-candidate commandAlpha 'apple pie' apricot asparagus avocado almonds artichoke anchovies anise aubergine 'adzuki beans' 'acorn squash' \; 'take {-11}, {10} and {11}' from '{@}'
    assert_output 'alpha-take apple pie, adzuki beans and acorn squash-from-apple pie-apricot-asparagus-avocado-almonds-artichoke-anchovies-anise-aubergine-adzuki beans-acorn squash'
}
