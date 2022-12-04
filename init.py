import os, sys

# if not root...kick out
if not os.geteuid()==0:
    sys.exit("\nYou must be root to run this application, please use sudo and try again.\n")
