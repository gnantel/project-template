//! Tests for building greeting messages.

use super::*;

#[test]
fn greet_addresses_the_given_name() {
    assert_eq!(greet("Ada"), "Hello, Ada!");
}
