#thosts
Easy toggling/querying sections of your hosts file.

##Installation

For now, clone the repo somewhere, then create a symbolic link to thosts somewhere in your path.  For example:
```sh
git clone git@github.com:ryanvz/thosts.git
ln -s thosts/thosts /usr/local/bin/thosts
```

##Usage

###Status

Run without arguments (or with option -l) To list the currently enabled sections.
This is an easy way to quickly check what sections are enabled
```sh
> thosts

remote_env = ON
widgets/dev = OFF
widgets/test = ON
widgets/staging = OFF
```

To print the effective hosts file, use the -p option.
This could be done by reading the hosts file directly, but without the clutter of the commented out sections
```sh
> thosts -p

127.0.0.1	localhost
255.255.255.255	broadcasthost
192.168.1.1 mysite.com
```

###Toggling Sections

*When modifying hosts, you will likely need root access, so use sudo to run thosts*

Simply pass the name of the section you wish to toggle
```sh
> sudo thosts remote_env

Enabled sections:
remote_env
widgets/test

> sudo thosts remote_env
widgets/test
```

###Groups
Use groups to enforce only one section being enabled among a group of a sections (think radio-button behavior).
To define a group, simply name the section with a forward slash separating the group name: `group/section`

Built-in help is also available
```sh
> thosts --help

```
