include:
  - sbuild.prereq

{% from 'schroot/state.jinja' import schroot_state_loop, schroot_guess_overlay_fs %}

{% set overlay_fs = '{0}'.format(schroot_guess_overlay_fs()) %}
{% set default_data = {
    'schroot_name_format': '{name}-{arch}-sbuild',
    'dist_aliases': True,
    'short_alias': False,
    'cdebootstrap_options': '--flavour=build',
    'debootstrap_options': '--variant=buildd',
} %}
{% set default_conf = {
    'union-type': overlay_fs,
    'profile': 'sbuild',
    'groups': 'root,sbuild',
    'root-groups': 'root,sbuild',
    'source-root-groups': 'root,sbuild',
} %}

{{ schroot_state_loop(root_key='sbuild', default_data=default_data,
                      default_conf=default_conf, sls_require='sbuild.prereq') }}

# Ensure the sbuild users are added to the sbuild group
{% set sbuild_users = salt.pillar.get('sbuild:users') %}
{% if sbuild_users %}
sbuild_users_in_sbuild_group:
  group.present:
    - name: sbuild
    - members: {{ salt.pillar.get('sbuild:users', [])|yaml }}
    - require:
      - sls: sbuild.prereq
{% endif %}

# Ensure the sbuild key is droppped, that way sbuild does not try
# to use gpg and relies on APT's configuration to trust the repository
/var/lib/sbuild/apt-keys:
  file.absent
