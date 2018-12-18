Given "I meet any person" {
}

When "I say 'hello world'" {
}

Then "the answer is (.*)" {
    param($Answer)
    $Answer | Should -Be "42"
}
