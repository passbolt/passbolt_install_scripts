	      ____                  __          ____
	     / __ \____  _____ ____/ /_  ____  / / /_
	    / /_/ / __ `/ ___/ ___/ __ \/ __ \/ / __/
	   / ____/ /_/ (__  |__  ) /_/ / /_/ / / /_
	  /_/    \__,_/____/____/_.___/\____/_/\__/

	Open source password manager for teams
	(c) 2018 Passbolt SARL
	https://www.passbolt.com


## Licence

Passbolt is distributed under [Affero General Public License v3](http://www.gnu.org/licenses/agpl-3.0.html)

# Passbolt install scripts

We have been installing passbolt A LOT internally to test new functionalities, to debug issues mimic some environment etc.
Sharing this scripts with the community will ease the installation procedure and allow users that do not want or can not use other
installation options to have passbolt installed.

## Why not a $place_your_distro_here package?

It is a matter of priorities and manpower. Currently we ship a docker container which is a good fit for any GNU/Linux distro
Windows and MacOS users. However we understand that some users do not want or can not use docker so we release this scripts for them.
We are not against packaging passbolt for specific platforms but right now we are focused on some other tasks.

## Requirements

This installation scripts must be run as root user as it is required to install
packages and use privileged ports such as 80 or 443.

__WARNING__ This installation scripts are designed to be executed on __FRESH__ created instances.
Running them on a previously provisioned system may lead to unknown states as well as it
could overwrite configuration files, etc.

## Usage

In order to use the scripts just run:

```bash ./dist/$distro/passbolt_$distro_installer.sh```

You can obtain the scripts for different platforms on the releases page or you can just git clone this repository
and build the scripts and use them.

## Building

In order to build the scripts for your operating system we provide a builder script.
The builder script will concat all the code required for your distro in a single file under:

```dist/$distro/passbolt_$disto_installer.sh```

In order to build the passbolt installer please execute the following:

```bash ./build_scripts.sh -d debian```

or

```bash ./build_scripts.sh -d centos```

When the building is done use the scripts from `dist/$distro` to install passbolt on your system.
## Development

There is a sample development passbolt installer script on tests folder where a
developer can test different functions together without building the whole script.

