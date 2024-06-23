---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
---

{% for post in site.posts reversed %}
  <h2><a href="/workshop/{{ post.url }}">{{ post.title }}</a></h2>
  <p>{{ post.content | markdownify }}</p>
{% endfor %}
