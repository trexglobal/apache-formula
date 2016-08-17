{% from "apache/map.jinja" import apache with context %}


{% set use_ppa        = salt['pillar.get']('apache:use_ppa', none) %}


{% if grains['os_family']=="Debian" and use_ppa is not none %}

{% set ppa_name = salt['pillar.get']('apache:ppa_name', 'ondrej/apache2') %}

apache_ppa:
  pkgrepo.managed:
        - ppa: {{ ppa_name }}
    pkg.latest:
        - name: {{ apache.server }}
        - refresh: True
    service:
      - running
      - name: {{ apache.service }}
      - enable: True    
{% else %}

apache:
  pkg:
    - installed
    - name: {{ apache.server }}
  service:
    - running
    - name: {{ apache.service }}
    - enable: True

{% endif %}

apache-reload:
  module:
    - wait
    - name: service.reload
    - m_name: {{ apache.service }}

apache-restart:
  module:
    - wait
    - name: service.restart
    - m_name: {{ apache.service }}
