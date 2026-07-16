---
name: Ansible, Eventually
tagline: Teaching my homelab to rebuild itself — infrastructure as code, learned the honest way.
status: in progress
stack: [Ansible, YAML, Linux]
order: 5
---

Every service on this domain currently exists because I built it by hand, and
hand-built means hand-rebuilt when something dies. This is the fix: an Ansible
stack that describes my systems as code, so the whole lot can be stood back up
from a clean machine and a git repo.

It's a work in progress in the truest sense — I'm learning to do it *right*
rather than fast, which means playbooks get rewritten as often as they get
written. Future me, restoring from a dead drive at midnight, will be grateful.
