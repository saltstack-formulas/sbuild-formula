{% from 'schroot/state.jinja' import schroot_basedir %}

# Ensure we have debootstrap/cdebootstrap
include:
  - debootstrap.prereq

# And sbuild (depends on schroot too)
sbuild:
  pkg.installed

# And the basedir hosting all chroots
sbuild_basedir:
  file.directory:
    - name: {{ schroot_basedir(root_key='sbuild') }}
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
