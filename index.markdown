---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
---

Red Hat Enterprise Linux派生のディストリビューションを使用した検証の記録とコマンド、設定集である。

{% for post in site.posts reversed %}
  <h2><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></h2>
  <p>{{ post.excerpt | markdownify }}</p>
{% endfor %}

