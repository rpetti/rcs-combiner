rcs-combiner
============

Simple Perl script that uses RCS to combine revisions from multiple ,v files into a single one.

This script was primarily created as a way to combine Perforce versioned files together in order
to recover from a situation where ",v" files have been removed or corrupted, but development
continues regardless.

Usage:
./rcs-combiner <path/to/A/version,v> <path/to/B/version,v> <path/to/new/version,v>

This will sort the revisions by date, then resubmit them into a new RCS file at the new path.
In the event of collisions (a specific revision number existing in both A and B) the revision from A is used.
