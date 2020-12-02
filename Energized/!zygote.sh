
#######################################################################################################
#####=============================== Package/Extension Information ===============================#####

NAME="Energized" #Package/Extension Name

TYPE="Extension" #Specify (Package / Extension)

AUTHOR="Jaxparrow" #Your name as the Developer/Owner/Packer

VERSION="1.0" #Specify the Version of this package/extension

SHORTDESC="Let's make an annoyance free better open internet, altogether!" #Provide a short description about this package/extension

C_EXTNAME="Energized" #For Specifing a custom name for your extension script ($NAME is used if not defined)

#####=============================== Package/Extension Information ===============================#####
#######################################################################################################




#------------------------------------------------------------------------------------------------------




#######################################################################################################
######=============================== Package/Extension Functions ===============================######

REQSYNC="yes" #Require Sync (Deafult - yes)

REQREBOOT="no" #(Deafult - no) Use if your package/extension modifies any major system file

GEN_UNINS="yes" #(Deafult - yes) If you want GearLock to generate a uninstallation script itself

SHOW_PROG="no" #(Default - yes) Whether to show extraction progress while loading the pkg/extension

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
