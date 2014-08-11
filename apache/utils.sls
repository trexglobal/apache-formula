{% if grains['os_family']=="Debian" %}

include:
  - apache

utils-pkg:
  pkg.installed:
    - name: apache2-utils

{% endif %}
