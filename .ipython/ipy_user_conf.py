# Most of your config files and extensions will probably start with this import

import os

import IPython.ipapi
import jobctrl

ip = IPython.ipapi.get()

# You probably want to uncomment this if you did %upgrade -nolegacy
# import ipy_defaults


def main():

    # ip.dbg.debugmode = True
    ip.dbg.debug_stack()

    # uncomment if you want to get ipython -p sh behaviour
    # without having to use command line switches
    import ipy_profile_sh

    # Configure your favourite editor?
    # Good idea e.g. for %edit os.path.isfile

    # import ipy_editors

    # Choose     one of these:

    # ipy_editors.scite()
    # ipy_editors.scite('c:/opt/scite/scite.exe')
    # ipy_editors.komodo()
    ipy_editors.idle()
    # ... or many others, try 'ipy_editors??' after import to see them

    # Or roll your own:
    # ipy_editors.install_editor("c:/opt/jed +$line $file")

    o = ip.options
    # An example on how to set options
    # o.autocall = 1
    o.system_verbose = 0

    # import_all("os sys")
    # execf('~/_ipython/ns.py')

    # -- prompt
    # A different, more compact set of prompts from the default ones, that
    # always show your current location in the filesystem:

    o.prompt_in1 = r'\H:\w\u\$\C_LightBlue[\C_LightCyan\Y2\C_LightBlue]\C_Normal\n\C_Green|\#>'
    o.prompt_in2 = r'.\D: '
    o.prompt_out = r'[\#] '

    # Try one of these color settings if you can't read the text easily
    # autoexec is a list of IPython commands to execute on startup
    # o.autoexec.append('%colors LightBG')
    # o.autoexec.append('%colors NoColor')
    o.autoexec.append('%colors Linux')


# some config helper functions you can use
def import_all(modules):
    """ Usage: import_all("os sys") """
    for m in modules.split():
        ip.ex("from %s import *" % m)


def execf(fname):
    """ Execute a file in user namespace """
    ip.ex('execfile("%s")' % os.path.expanduser(fname))


main()