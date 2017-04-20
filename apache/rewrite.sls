{% from "apache/map.jinja" import apache with context %}
{% if grains['os_family']=="Debian" %}

include:
  - apache

a2enmod rewrite:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/rewrite.load
    - order: 225
    - require:
      - pkg: {{ apache.pkg }}
    - watch_in:
      - module: apache-restart

{% endif %}
