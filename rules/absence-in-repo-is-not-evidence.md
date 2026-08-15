# A repo is not the whole product

When auditing docs or claims about what a product does, presence in the
current repo is evidence; absence is not. Pipelines, trained models, mobile
apps and databases routinely live outside the repo being read, and the repo
may hold only the last hop of a capability.

**Why:** the failure mode is reporting a real capability as nonexistent
because the only visible layer (seed data, an event type, a rendered row)
does not carry it. Layers also answer different questions: a doc about what
the product "captures" may describe an upstream layer while a reader arriving
from the UI assumes the rendered one, and an audit that conflates the two
produces confident false negatives.

**How to apply:** write "not represented in this repo", never "does not
exist", and name the layer the evidence comes from. Before declaring a gap,
ask whether the capability could live upstream of anything this repo can see,
and route the question to someone with access to that layer rather than
closing it.
