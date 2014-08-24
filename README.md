
# Yet another dotfiles repo #

These are my config files so I can clone them onto a new machine easily.

There is an install script (install.sh) and a configuration file (install.cfg)
which control how the various dotfiles will get copied or linked into the home
directory.

It only needs bash and grep to work. I'm using it on OSX (Darwin), Debian and
Redhat (Linux) and Msys Windows (MINGW32_NT-6.2)

To use clone the repo and do

     bash install.sh -h

for the help

      Usage:     ./install.sh -nv -s source_dir -d dest_dir -m hostname -o os configfile

           -n     dry run, don't make any changes
           -s     source dirrectory. Defaults to the location of install.sh
           -d     destination directory. Defaults to $HOME
           -c     copy files instead of linking
           -v     verbose output
           -m     override machine hostname (defaults to output of hostname)
           -o     override operating system (defaults to output of uname)
           -h     display this message

       configfile is a colon seperated list of destination:source:host_pattern:os_pattern

         .bashrc:my_bashrc.bash:satur.*:Linux|Darwin

	   will link/copy source_dir/my_bashrc.bash to dest_dir/.bashrc if the
	   hostname begins with satur (saturday, saturn etc..) and uname is either
	   Darwin or Linux.  Patterns are passed to grep -E  an empty pattern will
	   match any host/platform

Edit the config file (install.cfg) or create a new one. Then see what will
happen

     bash install.sh -nv install.cfg

remove the 'n' to really run it.  Any files that get clobbered will be moved
to $HOME/backups-yyyymmdd. In the default mode (link) you should be able to
run it again and nothing will be touched.  In copy mode, the files will keep
geting backed up

