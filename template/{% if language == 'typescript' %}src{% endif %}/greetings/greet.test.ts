/** Tests for building greeting messages. */

import { expect, test } from "vitest";
import { greet } from "./greet.ts";

test("greet addresses the given name", () => {
  expect(greet("Ada")).toBe("Hello, Ada!");
});
