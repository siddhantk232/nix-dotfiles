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
  '';
}
