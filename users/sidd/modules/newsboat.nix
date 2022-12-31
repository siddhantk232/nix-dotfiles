{ pkgs, ... }:
{
  home.packages = [
    pkgs.newsboat
  ];

  home.file.".newsboat/urls".text = ''
    https://siddhantcodes.netlify.app/feed.xml
    https://blogs.nasa.gov/webb/feed/
    https://monicalent.com/blog/index.xml
    https://hnrss.org/jobs
    https://hnrss.org/bestcomments
    https://hnrss.org/frontpage
    https://fasterthanli.me/index.xml
    https://xn--i2r.xn--rhqv96g/rss.xml
    https://world.hey.com/dhh/feed.atom
    http://jackkelly.name/blog/rss.xml
    https://lexi-lambda.github.io/feeds/all.rss.xml
  '';
}
