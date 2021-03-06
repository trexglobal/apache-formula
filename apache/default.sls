{% from "apache/map.jinja" import apache with context %}
{% if grains['os_family']=="Debian" %}

include:
  - apache

/etc/apache2/sites-enabled/000-default.conf:
  file.managed:
    - source: salt://apache/files/000-default.conf
    - watch_in:
      - module: apache-restart
    - require:
      - pkg: {{ apache.pkg }}

{% endif %} #END: os = debian
