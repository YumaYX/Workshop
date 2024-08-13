---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: default
---

本プロジェクトは、Red Hat Enterprise Linux派生のディストリビューションを使用した検証の記録である。よく使うコマンドや設定集を紹介する。

{% for post in site.posts reversed %}
  <h2><a href="{{ site.baseurl }}{{ post.url }}">{{ post.title }}</a></h2>
  {{ post.excerpt | markdownify }}
{% endfor %}
