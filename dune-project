(lang dune 2.5)
(name ocplib-jsutils)
(allow_approximate_merlin)

(generate_opam_files true)

(source (github ocamlpro/ocplib-jsutils))
(license GPL-3.0-or-later)
(authors
 "Cagdas Bozman <cagdas.bozman@ocamlpro.com>"
 "Michael Laporte <michael.laporte@ocamlpro.com>"
 "Fabrice Le Fessant <fabrice.le_fessant@ocamlpro.com>"
 "Maxime Levillain <maxime.levillain@ocamlpro.com>"
 "Steven de Oliveira <steven.de_oliveira@ocamlpro.com>")
(maintainers "Fabrice Le Fessant <fabrice.le_fessant@ocamlpro.com>")
(documentation "https://ocamlpro.github.io/ocplib-jsutils/doc")

(package
 (name ocplib-jsutils)
 (synopsis "A collection of useful libraries to build sites with js_of_ocaml")
 (depends
  (js_of_ocaml-tyxml (>= 3.4.0))
  (lwt (>= 4.0.0))
  stdlib-shims)
 (depopts (base64 (>= 3.2.0))))

(package
 (name ocplib-jsmin)
 (synopsis "A minimal helper for js and dom object")
 (depends
  (js_of_ocaml-ppx (>= 3.4.0))
  stdlib-shims))

(package
 (name ocplib-ace)
 (synopsis "Ace binding")
 (depends (js_of_ocaml-ppx (>= 3.4.0))))

(package
 (name ocplib-amcharts3)
 (synopsis "Amcharts3 binding")
 (depends (js_of_ocaml-ppx (>= 3.4.0))))

 (package
 (name ocplib-bs4)
 (synopsis "Bootstrap4 helpers")
 (depends
  (js_of_ocaml-ppx (>= 3.4.0))
  ocplib-cleave ocplib-jquery))

(package
 (name ocplib-cleave)
 (synopsis "Binding for Cleave JS")
 (depends (js_of_ocaml-ppx (>= 3.4.0))))

(package
 (name ocplib-cytoscape)
 (synopsis "Binding for Cytoscape")
 (depends ocplib-jsutils))

(package
 (name ocplib-d3pie)
 (synopsis "Binding for D3Pie")
 (depends (js_of_ocaml-ppx (>= 3.4.0))))

(package
 (name ocplib-disqus)
 (synopsis "Binding for Disqus")
 (depends ocplib-jsutils))

(package
 (name ocplib-extension)
 (synopsis "Binding for chrome and firefox extension API")
 (depends ocplib-jsmin)
 (depopts lwt))

(package
 (name ocplib-jquery)
 (synopsis "Binding for JQuery")
 (depends ocplib-jsutils))

(package
 (name ocplib-odometer)
 (synopsis "Binding for Odometer JS")
 (depends (js_of_ocaml-ppx (>= 3.4.0))))

(package
 (name ocplib-push-js)
 (synopsis "Binding for Push Notification JS")
 (depends (js_of_ocaml-ppx (>= 3.4.0))))

(package
 (name ocplib-qrcode-js)
 (synopsis "Binding for Qrcode JS")
 (depends (js_of_ocaml-ppx (>= 3.4.0))))

(package
 (name ocplib-recaptcha-js)
 (synopsis "Binding for Client Side Recaptcha")
 (depends (js_of_ocaml-ppx (>= 3.4.0))))