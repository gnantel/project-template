//! Builds greeting messages.

pub fn greet(name: &str) -> String {
    format!("Hello, {name}!")
}

#[cfg(test)]
#[path = "greet_tests.rs"]
mod tests;
