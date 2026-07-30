/// A source of the current time, injected so tests can fix a moment without
/// touching the system clock.
///
/// This file is pure Dart: it has no Flutter import.
library;

/// A function returning the current [DateTime].
///
/// Production code passes [systemClock]; tests pass a function returning a
/// fixed [DateTime] instead.
typedef Clock = DateTime Function();

/// The default [Clock] implementation, delegating to [DateTime.now].
DateTime systemClock() => DateTime.now();
