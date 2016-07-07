## Resubmission
This is a resubmission to fix a failure to build across OSes on CRAN. In this version I have:

* Written a OS-portable function to convert Unicode to ASCII instead of relying on `iconv(s, to="ASCII//TRANSLIT")`
* Tested in a local Windows 10 and a local OS X environment
* Bumped version to 0.1.1

## Test environments
* local ubuntu 14.04.4, R 3.3.1
* local windows 10, R 3.3.1
* local OS X 10.9.5, R 3.2.3
* win-builder

## R CMD check results
There were no ERRORs or WARNINGs.

There was 1 NOTE when checked on OS X:

* checking data for non-ASCII characters ... NOTE
  Note: found 60 marked UTF-8 strings

Data contains Vietnam's provinces' names, which are in UTF-8.
