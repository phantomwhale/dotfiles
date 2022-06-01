# i18n testing functions for 99designs
#
function i18n-open() {
  for site in 99designs.com.au 99designs.de 99designs.es 99designs.fr 99designs.jp 99designs.nl 99designs.pt; do
    open "https://$site$1?noredirect=1";
  done
}

function i18n-experiment() {
  for site in 99designs.com.au 99designs.de 99designs.es 99designs.fr 99designs.jp 99designs.nl 99designs.pt; do
    open "https://$site/bastion/experiments/$1/masquerade/${2:-enabled}"
  done
}
