# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased](https://github.com/passbolt/passbolt_install_scripts/compare/v0.5.1...HEAD)

## [0.5.1](https://github.com/passbolt/passbolt_install_scripts/compare/v0.5.1..v0.5.0) - 2020-09-25

### Fixed
- php-fpm incorrect group name for socket communications configuration

## [0.5.0](https://github.com/passbolt/passbolt_install_scripts/compare/v0.5.0..v0.4.0) - 2020-04-20

This release adds support to configure firewalls on centos platform to open passbolt necessary ports
and it also introduces EXPERIMENTAL support for Red Hat Enterprise Linux.

### Added

- Open ports 80 and 443 on centos firewalls [#6](Centos: Firewall left unconfigured blocking access to passbolt interface.)
- Experimental support for RHEL installations from version 7.0
    * Use of software collections:
       1. rhel-server-rhscl-7-rpms
       2. rhel-7-server-extras-rpms
       3. rhel-7-server-optional-rpms
    * Use of Epel-release repository
    * Setup firewall to open ports 80 and 443
    * Support for certbot for lets encrypt

## [0.4.0](https://github.com/passbolt/passbolt_install_scripts/compare/v0.4.0..v0.3.2) - 2019-08-07

### Fixed
- Error on mariadb create syntax [#9](https://github.com/passbolt/passbolt_install_scripts/issues/9)
- Centos cron error output [#8](https://github.com/passbolt/passbolt_install_scripts/issues/8)
- Centos selinux errors [#7](https://github.com/passbolt/passbolt_install_scripts/issues/7)
- Dist tar files break permissions on host [#5](https://github.com/passbolt/passbolt_install_scripts/issues/5)
- Nginx is not configured for ipv6 [#4](https://github.com/passbolt/passbolt_install_scripts/issues/4)

## [0.3.2](https://github.com/passbolt/passbolt_install_scripts/compare/v0.3.2..v0.3.1) - 2019-02-12

### Fixed
- build_script.sh now correctly concats ubuntu helper scripts

## [0.3.1](https://github.com/passbolt/passbolt_install_scripts/compare/v0.3.1..v0.3.0) - 2019-02-12

### Added

- Build script minor updates

### Fixed

- Increased server_names_hash_bucket_size to 64 [#3](https://github.com/passbolt/passbolt_install_scripts/issues/3)
- Help site banner on haveged points now to the correct help.passbolt.com URL

## [0.3.0](https://github.com/passbolt/passbolt_install_scripts/compare/v0.3.0..v0.2.1) - 2019-02-12

### Fixed

- Typo: bad domain name for LetsEncrypt [#2](https://github.com/passbolt/passbolt_install_scripts/pull/2)
- Install composer using wget to enable proxy scenarios to work
- Correct www_home permissions to allow composer create caches

## [0.2.1](https://github.com/passbolt/passbolt_install_scripts/compare/v0.2.1..v0.2.0) - 2018-11-14

### Added

- missing ubuntu packages: php-ldap

## [0.2.0](https://github.com/passbolt/passbolt_install_scripts/compare/v0.2.0..v0.1.0) - 2018-11-14

### Added

- apt-get update is executed before installing packages on ubuntu/debian flavours

## [0.1.0](https://github.com/passbolt/passbolt_install_scripts/releases/tag/v0.1.0) - 2018-11-13

### Added

- Support for debian 9.6 support
- Support for centos 7
- Support for ubuntu 18.10
