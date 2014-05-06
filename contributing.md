---
layout: default
title: Contributing
---

Drivers
-------

I you want me to include your driver, please follow these rules:

* The license the code is released under has to be GPL version 2 or later. Add this information at the top of the file.
* Agree with the [Developer's Certificate of Origin 1.1](https://www.kernel.org/doc/Documentation/SubmittingPatches) (12. Sign your work)
* Follow the [Linux kernel coding style](https://www.kernel.org/doc/Documentation/CodingStyle)  
  Use ```scripts/checkpatch.pl --file drivers/video/fbtft/fb_xxx.c``` to verify your code.  
  Lines can exceed 80 columns if the meaning is hard to grasp when breaking up the line. Never exceed 132 columns.
* If you want a pre-review, make an [issue](https://github.com/notro/fbtft/issues) and include your driver/change in a [code block](https://help.github.com/articles/github-flavored-markdown#fenced-code-blocks) for review.
* Only one fix/feature per commit

I accept simple changes directly from an issue, a pull request is not needed.


Documentation
-------------

Jekyll is used to build [fbtft.org](http://fbtft.org) using <https://github.com/notro/fbtft.org>  
In addition to that, the [wiki](https://github.com/notro/fbtft.org/wiki) is also pulled in before building.  
A change to the wiki triggers a rebuild of this site (<http://fbtft.org/build.log>).

The wiki pages have a [Front-matter](http://jekyllrb.com/docs/frontmatter/) that instructs Jekyll how to process the file.  
[Kramdown](http://kramdown.gettalong.org/quickref.html) is used for [Markdown](http://en.wikipedia.org/wiki/Markdown) parsing.

Everyone with a gihub account can make changes to the wiki.
