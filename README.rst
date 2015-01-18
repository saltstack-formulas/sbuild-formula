======
sbuild
======

This formula makes it easy to configure sbuild and the associated
build chroots. It relies on schroot-formula and debootstrap-formula
to setup the required build chroots.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``sbuild``
----------

Create chroots described in pillar data below ``sbuild:chroots``. The
chroot description is an extension of the pillar data used by
``schroot-formula`` and ``debootstrap-formula`` (check their
documentation to learn the basics) with the following changes:

- The chroot name (as registered in schroot) is generated with the
  ``<identifier>-<architecture>-sbuild`` template (where identifier is the
  name of the top-level key).
- ``dist_aliases`` defaults to True
- ``short_alias`` defaults to False
- The default schroot configuration is modified so that users in the
  sbuild group have full access to the chroots and so that builds
  use a temporary aufs overly.

Here's a quick sample::

    sbuild:
      basedir: /srv/sbuild
      chroots:
        sid:                          # the base distribution
          vendor: debian              # the name of the vendor
          architectures:
            - amd64
            - i386
          extra_dists:                # extra APT repositories to enable
            - experimental
          with_source: True           # include deb-src entries in sources.list
        jessie:
          ...

``sbuild.prereq``
-----------------

Ensure that sbuild is installed and that the base directory hosting
chroots exists. In general, there's no reason to use this state directly.
The fact that it is separated from ``sbuild`` is only due to an implementation
detail.

``Configuration``
=================
See the pillar.example file to have an idea of everything that can
be customized in this formula.
