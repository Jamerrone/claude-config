# Persisted values are contracts

Treat any enum member or string value that is persisted, decoded from stored
data at runtime, or shared with another repo or service as a contract.
Removing or renaming it is a data migration, not a rename.

**Why:** a value that looks like a UI enum can be written into stores and
copied into other codebases that validate by exact value; a rename then
breaks decoding of existing data, and the break surfaces at read time, far
from the diff that caused it. A nicer name is rarely worth a coordinated
migration across every store and repo that holds the old one.

**How to apply:** before renaming or removing a member, find every boundary
its raw value crosses: persisted records, API payloads, per-user preferences,
other repos' copies. If any exist, the change needs backward-compatible
decoding at each one, and that cost usually decides against the rename. A
member with no UI representation may still be load-bearing in stored data, so
"nothing renders this" is not evidence it is safe to delete.
