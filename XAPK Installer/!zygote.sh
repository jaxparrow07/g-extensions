
#######################################################################################################
#####=============================== Package/Extension Information ===============================#####

NAME="XAPK Installer" #Package/Extension Name

TYPE="Extension" #Specify (Package / Extension)

AUTHOR="Jaxparrow" #Your name as the Developer/Owner/Packer

VERSION="2.6" #Specify the Version of this package/extension

SHORTDESC="Install XAPK files Easily" #Provide a short description about this package/extension

C_EXTNAME="XAPK-Installer" #For Specifing a custom name for your extension script ($NAME is used if not defined)

#####=============================== Package/Extension Information ===============================#####
#######################################################################################################




#------------------------------------------------------------------------------------------------------




#######################################################################################################
######=============================== Package/Extension Functions ===============================######

REQSYNC="yes" #(Deafult - yes) To make sure all your files are properly written in disk

REQREBOOT="no" #(Deafult - no) Use if your package/extension modifies any major system file

GEN_UNINS="no" #(Deafult - no) If you want GearLock to generate an uninstallation script itself

SHOW_PROG="yes" #(Default - yes) Whether to show extraction progress while loading the pkg/extension

DEF_HEADER="yes" #(Default -yes) Whether to use the default header which print's the info during zygote

######=============================== Package/Extension Functions ===============================######
#######################################################################################################




#------------------------------------------------------------------------------------------------------




#######################################################################################################
######======================================= CustomHeader ======================================######
                        #Do not edit this part unless you know what you're doing#
                #Set `DEF_HEADER` to `no' if you want to specify a custom zygote header#
       #Then you can use `geco` or `cat` to print your custom header below for the zygote stage#





######========================================== Header =========================================######
#######################################################################################################
