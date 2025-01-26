---
title: Hugo
date: 2025-01-01T08:06:25+06:00
description: Hugo 블로그 이전
menu:
  sidebar:
    name: Hugo
    identifier: sub-hugo
    parent: blog-migration
    weight: 20
tags:
- Hugo
- Hugo-Toha Theme
- Manual
---

https://github.com/hugo-toha/hugo-toha.github.io  
https://toha-guides.netlify.app/  
https://github.com/hugo-toha/guides  




### Writting Tips

<details>
<summary> Collapsed Sections </summary>

#### Collapsed Sections [^collapsed-sections] 


```html
<details>
  Collapsed text
</details>

<details>
  <summary>Details Title</summary>
  Collapsed text
</details>
```
<details>
<summary>Details Title</summary>
Collapsed text
</details>


</details>


<details>
<summary>Using undefined shortcodes Print</summary>

#### Using undefined shortcodes Print [^shortcode-escape]

메뉴얼을 위해 Hugo 의 Shortcode를 호출하는 code를 포스트안에 작성하려고 했으나,  
{{/*< ... >*/}} 의 형태로 작성되면 Hugo의 랜더링 과정에서 callout하게 되어,  
관련된 shortcode를 참조하게 됩니다.  

때문에 메뉴얼 작성을 위한 shortcode를 문자 그대로 출력하기 위해선, Escaping 과정을 거쳐야 합니다.  

여려가지 방법이 있었으나, code block안에서는 정상적으로 출력이 안되는 등 가능한 방법은 한가지 뿐이였습니다.

먼저 가능한 예제를 보여드리고, 불가능한 예제들도 소개해 드리겠습니다.  
저처럼 시행착오를 반복하기 않기를 바라겠습니다!  

`정상적인 Case`
* Shortcode 문자 그대로 출력하는 방법  
  {{\/*< ... >\*/}} 의 내부에 주석을 넣는 방법을 사용하면 됩니다.
  예를 들어 `tag list` 를 반환하는 `Shortcode` 를 작성 하고 싶다면, 하단처럼 작성하면 됩니다.

  ``` go
  {{</*/* partial "tags/custom-list.html" */*/>}}
  ```

`실패한 Case` [^Liquid-Template-raw]
* {{%/* raw */%}} 사용  
  liquid Template 언어에 따르면 {{%/* raw */%}} ... {{%/* /raw */%}} 의 형태로 사용하면 일시적으로 랜더링을 멈출 수 있다고 하나, Hugo 는 `Go언어의 Template`을 사용하기 떄문에 적용 할 수 없습니다.    
  예전 Jekyll 때는 Liquid를 사용했으나 현재는 Hugo를 사용하므로 해당 방법은 적용 불가 합니다.






</details>



## Template

### Custom Layout
<details>
<summary>Example-All tag list Template</summary>

#### Example-All tag list Template

1. hugo.yaml 에서 markup unafe 설정 확인
2. layouts에 paritals와 shortcodes 생성

    ``` shell
    mkdir -p layouts/partials layouts/shortcodes
    ```
3. tag 리스트를 생성하는 partial custom-list.html 생성
    ```shell
    $ mkdir -p layouts/partials/tags
    $ vim layouts/partials/tags/custom-list.html
    <!-- layouts/partials/tags/custom-list.html -->
    <h2>All Tags</h2>
    <ul>
      {{ range $tag, $items := .Site.Taxonomies.tags }}
        <li><a href="{{ "/tags/" | relLangURL }}{{ $tag }}">{{ $tag }}</a> ({{ len $items }} posts)</li>
      {{ end }}
    </ul>
    :wq

    ```

4. 페이지 내부에서 custom-list 템플릿을 불러 올 수 있도록 partoal shortcode 생성
    ```shell
    vim layouts/shortcodes/partial.html
    {{ partial (.Get 0) . }}
    :wq


    ```


5. 특정 페이지 내에서 custom-list template 호출
    예시) contents/post/sample.md
    ``` markdown
    ---
    title: "Sample Post"
    date: 2025-01-01T09:12:43+05:00
    tags:
    - Hugo
    - Example
    #draft: false
    ---

    # Sample Post

    This page lists all tags:
    
 
   
    {{</* partial "tags/custom-list.html" */>}}
    
    ```
6. 




</details>





### Creating Sub Category

https://toha-guides.netlify.app/posts/writing-posts/organizing/sub-category/example/






## Reference


[Hugo 관련 팁](https://github.com/kaushalmodi/ox-hugo/blob/main/test/site/content/posts/source-block-md-with-hugo-shortcodes.md)


###### Foot Note

[^collapsed-sections]: [Github-collapsed-sections 참고](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/organizing-information-with-collapsed-sections)

[^shortcode-escape]: [Shortcodes escaped 참고](https://github.com/kaushalmodi/ox-hugo/blob/main/test/site/content/posts/source-block-md-with-hugo-shortcodes.md#shortcodes-escaped-shortcodes-escaped)

[^Liquid-Template-raw]: [Liquid Template raw 참고](https://shopify.github.io/liquid/tags/template/)