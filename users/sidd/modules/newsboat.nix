{ pkgs, ... }:
{
  home.packages = [
    pkgs.newsboat
  ];

  home.file.".newsboat/urls".text = ''
    https://jaredforsyth.com/posts/rss.xml
    https://blogs.nasa.gov/webb/feed/
    https://fasterthanli.me/index.xml
    http://jackkelly.name/blog/rss.xml
    https://lexi-lambda.github.io/feeds/all.rss.xml
    https://blog.ncase.me/feed.xml
    https://www.scattered-thoughts.net/atom.xml
    https://buttondown.email/pdubroy/rss
    https://matklad.github.io/feed.xml
    https://raphlinus.github.io/feed.xml
    https://without.boats/index.xml
  '';
}
