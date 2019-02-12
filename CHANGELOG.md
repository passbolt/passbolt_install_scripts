# Change Log

All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased](https://github.com/passbolt/passbolt_install_scripts/compare/v0.3.0...HEAD)

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
