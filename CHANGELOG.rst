sbuild formula
==============

1.0.0 (2016-09-30)

- Requires sbuild >= 0.70 (available in jessie-backports) and works
  without any GPG key. Drop the sbuild key to force sbuild to use
  the "[trusted]" syntax in /etc/apt/sources.list instead.

0.0.3 (2015-10-05)

- Add `sbuild:users` pillar data to auto-add sbuild users to the sbuild
  group.

0.0.2 (2015-08-31)

- Use schroot's new auto-detection feature of overlay filesystem
  supported. Needs version 0.0.2 of schroot formula.

0.0.1 (2015-01-17)

- Initial version
