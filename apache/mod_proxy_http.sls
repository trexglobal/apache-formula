{% from "apache/map.jinja" import apache with context %}
{% if grains['os_family']=="Debian" %}

include:
  - apache
  - apache.mod_proxy

a2enmod proxy_http:
  cmd.run:
    - unless: ls /etc/apache2/mods-enabled/proxy_http.load
    - order: 225
    - require:
      - pkg: {{ apache.pkg }}
      - cmd: a2enmod proxy
    - watch_in:
      - module: apache-restart

{% endif %}
