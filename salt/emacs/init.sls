{% from 'macros.sls' import user, group with context %}

{% if grains['kernel'] == 'Darwin' %}

{% if not salt['file.directory_exists'](salt['environ.get']('HOME') + '/Applications/Emacs.app') %}

Download the Emacs app:
    file.managed:
        - name: /tmp/emacs.dmg
        - source: https://emacsformacosx.com/download/emacs-builds/Emacs-25.2-universal.dmg
        - source_hash: 5a11c3e2aadaa45455fedefcc4fb96532b02baeeb0db0a6cc3ae5beaac7dc7d732c0b5c647305cd6f45c69aa65b63d51f92a6fe7ba55ae2dd07981f9ec3c228e
        - require_in: Install Emacs app

Install Emacs app:
    macpackage.installed:
        - name: /tmp/emacs.dmg
        - dmg: True
        - app: True
        - target: {{ salt['environ.get']('HOME') }}/Applications/Emacs.app

{% endif %}

{% elif grains['os'] == 'Ubuntu' %}

{% if grains['osrelease'] == '14.04' %}

Install Emacs:
    pkgrepo.managed:
        - ppa: ubuntu-elisp/ppa
    pkg.latest:
        - name: emacs-snapshot
        - refresh: True

{% endif %}

{% endif %}

{{ salt['environ.get']('HOME') }}/.emacs.d/:
    file.recurse:
        - source: salt://emacs/.emacs.d
        {{ user() }}
        {{ group() }}
